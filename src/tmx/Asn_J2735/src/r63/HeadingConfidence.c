/*
 * Generated by asn1c-0.9.29 (http://lionet.info/asn1c)
 * From ASN.1 module "DSRC"
 * 	found in "J2735_201603_ASN_CC.asn"
 * 	`asn1c -gen-PER -fcompound-names -fincludes-quoted -fskeletons-copy`
 */

#include "HeadingConfidence.h"

/*
 * This type is implemented using NativeEnumerated,
 * so here we adjust the DEF accordingly.
 */
static asn_oer_constraints_t asn_OER_type_HeadingConfidence_constr_1 CC_NOTUSED = {
	{ 0, 0 },
	-1};
asn_per_constraints_t asn_PER_type_HeadingConfidence_constr_1 CC_NOTUSED = {
	{ APC_CONSTRAINED,	 3,  3,  0,  7 }	/* (0..7) */,
	{ APC_UNCONSTRAINED,	-1, -1,  0,  0 },
	0, 0	/* No PER value map */
};
static const asn_INTEGER_enum_map_t asn_MAP_HeadingConfidence_value2enum_1[] = {
	{ 0,	11,	"unavailable" },
	{ 1,	9,	"prec10deg" },
	{ 2,	9,	"prec05deg" },
	{ 3,	9,	"prec01deg" },
	{ 4,	10,	"prec0-1deg" },
	{ 5,	11,	"prec0-05deg" },
	{ 6,	11,	"prec0-01deg" },
	{ 7,	13,	"prec0-0125deg" }
};
static const unsigned int asn_MAP_HeadingConfidence_enum2value_1[] = {
	7,	/* prec0-0125deg(7) */
	6,	/* prec0-01deg(6) */
	5,	/* prec0-05deg(5) */
	4,	/* prec0-1deg(4) */
	3,	/* prec01deg(3) */
	2,	/* prec05deg(2) */
	1,	/* prec10deg(1) */
	0	/* unavailable(0) */
};
const asn_INTEGER_specifics_t asn_SPC_HeadingConfidence_specs_1 = {
	asn_MAP_HeadingConfidence_value2enum_1,	/* "tag" => N; sorted by tag */
	asn_MAP_HeadingConfidence_enum2value_1,	/* N => "tag"; sorted by N */
	8,	/* Number of elements in the maps */
	0,	/* Enumeration is not extensible */
	1,	/* Strict enumeration */
	0,	/* Native long size */
	0
};
static const ber_tlv_tag_t asn_DEF_HeadingConfidence_tags_1[] = {
	(ASN_TAG_CLASS_UNIVERSAL | (10 << 2))
};
asn_TYPE_descriptor_t asn_DEF_HeadingConfidence = {
	"HeadingConfidence",
	"HeadingConfidence",
	&asn_OP_NativeEnumerated,
	asn_DEF_HeadingConfidence_tags_1,
	sizeof(asn_DEF_HeadingConfidence_tags_1)
		/sizeof(asn_DEF_HeadingConfidence_tags_1[0]), /* 1 */
	asn_DEF_HeadingConfidence_tags_1,	/* Same as above */
	sizeof(asn_DEF_HeadingConfidence_tags_1)
		/sizeof(asn_DEF_HeadingConfidence_tags_1[0]), /* 1 */
	{ &asn_OER_type_HeadingConfidence_constr_1, &asn_PER_type_HeadingConfidence_constr_1, NativeEnumerated_constraint },
	0, 0,	/* Defined elsewhere */
	&asn_SPC_HeadingConfidence_specs_1	/* Additional specs */
};

