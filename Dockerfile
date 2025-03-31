ARG UBUNTU_VERSION=jammy-20230126
ARG TARGETPLATFORM

######################
# Dependencies stage #
######################
FROM --platform=$TARGETPLATFORM ubuntu:$UBUNTU_VERSION AS dependencies

ENV DEBIAN_FRONTEND=noninteractive

# 1. Copy & run install_dependencies.sh
ADD scripts/install_dependencies.sh /usr/local/bin/
RUN sed -i 's|http://archive.ubuntu.com|http://us.archive.ubuntu.com|g' /etc/apt/sources.list
RUN /usr/local/bin/install_dependencies.sh

# 2. Build ext components (all for ARM if platform=linux/arm64)
COPY ./ext /home/V2X-Hub/ext
WORKDIR /home/V2X-Hub/ext
RUN ./build.sh

# 3. Copy container scripts
ADD container/wait-for-it.sh /usr/local/bin/
ADD container/service.sh /usr/local/bin/
COPY ./container /home/V2X-Hub/container

WORKDIR /home/V2X-Hub/container
RUN ./database.sh
RUN ./library.sh
RUN ldconfig

# 4. Copy & build internal components
COPY ./src /home/V2X-Hub/src

RUN echo "=== DEBUG: Listing contents of r63 ===" && \
    ls -R /home/V2X-Hub/src/tmx/Asn_J2735/src/r63 || true

RUN echo "=== DEBUG: Listing contents of r2020 ===" && \
    ls -R /home/V2X-Hub/src/tmx/Asn_J2735/src/r2020 || true

WORKDIR /home/V2X-Hub/src
RUN ./build.sh release
RUN ldconfig


######################
# Final image stage  #
######################
FROM --platform=$TARGETPLATFORM ubuntu:$UBUNTU_VERSION AS v2xhub

ENV DEBIAN_FRONTEND=noninteractive

ADD scripts/deployment_dependencies.sh /usr/local/bin/
RUN /usr/local/bin/deployment_dependencies.sh

COPY ./container /home/V2X-Hub/container/
WORKDIR /home/V2X-Hub/container/
RUN ./database.sh
RUN ./library.sh
RUN ldconfig

# Copy build outputs from 'dependencies' stage (now also ARM64 if you run for ARM)
COPY --from=dependencies /usr/local/plugins/ /usr/local/plugins/
COPY --from=dependencies /usr/local/include/ /usr/local/include/
COPY --from=dependencies /usr/local/lib/ /usr/local/lib/
COPY --from=dependencies /usr/local/bin/ /usr/local/bin/
COPY --from=dependencies /usr/lib/ /usr/lib/
COPY --from=dependencies /usr/bin/ /usr/bin/
COPY --from=dependencies /usr/local/share/ /usr/local/share/
COPY --from=dependencies /var/www/plugins/ /var/www/plugins/
COPY --from=dependencies /var/log/tmx/ /var/log/tmx/
COPY --from=dependencies /opt/ /opt/

ADD src/tmx/TmxCore/tmxcore.service /lib/systemd/system/
ADD src/tmx/TmxCore/tmxcore.service /usr/sbin/
RUN ldconfig

RUN /home/V2X-Hub/container/setup.sh

WORKDIR /var/log/tmx

# Set metadata labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="V2X-Hub-Deployment"
LABEL org.label-schema.description="Image V2X-Hub Deployment"
LABEL org.label-schema.vendor="Leidos"
LABEL org.label-schema.version="${VERSION}"
LABEL org.label-schema.url="https://highways.dot.gov/research/research-programs/operations"
LABEL org.label-schema.vcs-url="https://github.com/usdot-fhwa-ops/V2X-HUB"
LABEL org.label-schema.vcs-ref=${VCS_REF}
LABEL org.label-schema.build-date=${BUILD_DATE}

ENTRYPOINT ["/usr/local/bin/service.sh"]
