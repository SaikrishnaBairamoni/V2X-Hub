PROJECT ( MapPlugin VERSION 7.3.1 LANGUAGES CXX )

SET (TMX_PLUGIN_NAME "MAP")

FIND_PACKAGE (XercesC REQUIRED)

BuildTmxPlugin ()

TARGET_INCLUDE_DIRECTORIES ( ${PROJECT_NAME} PUBLIC ${XercesC_INCLUDE_DIRS} )
TARGET_LINK_LIBRARIES ( ${PROJECT_NAME} tmxutils ${XercesC_LIBRARY} )
