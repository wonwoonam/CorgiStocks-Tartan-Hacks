/* This file was generated by upbc (the upb compiler) from the input
 * file:
 *
 *     envoy/config/listener/v3/udp_listener_config.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#if COCOAPODS==1
  #include  "third_party/upb/upb/def.h"
#else
  #include  "upb/def.h"
#endif
#if COCOAPODS==1
  #include  "src/core/ext/upbdefs-generated/envoy/config/listener/v3/udp_listener_config.upbdefs.h"
#else
  #include  "envoy/config/listener/v3/udp_listener_config.upbdefs.h"
#endif

extern upb_def_init google_protobuf_any_proto_upbdefinit;
extern upb_def_init udpa_annotations_status_proto_upbdefinit;
extern upb_def_init udpa_annotations_versioning_proto_upbdefinit;
extern const upb_msglayout envoy_config_listener_v3_UdpListenerConfig_msginit;
extern const upb_msglayout envoy_config_listener_v3_ActiveRawUdpListenerConfig_msginit;

static const upb_msglayout *layouts[2] = {
  &envoy_config_listener_v3_UdpListenerConfig_msginit,
  &envoy_config_listener_v3_ActiveRawUdpListenerConfig_msginit,
};

static const char descriptor[544] = {'\n', '2', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '/', 'v', 
'3', '/', 'u', 'd', 'p', '_', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '_', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'p', 'r', 'o', 
't', 'o', '\022', '\030', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', 
'.', 'v', '3', '\032', '\031', 'g', 'o', 'o', 'g', 'l', 'e', '/', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '/', 'a', 'n', 'y', '.', 
'p', 'r', 'o', 't', 'o', '\032', '\035', 'u', 'd', 'p', 'a', '/', 'a', 'n', 'n', 'o', 't', 'a', 't', 'i', 'o', 'n', 's', '/', 's', 
't', 'a', 't', 'u', 's', '.', 'p', 'r', 'o', 't', 'o', '\032', '!', 'u', 'd', 'p', 'a', '/', 'a', 'n', 'n', 'o', 't', 'a', 't', 
'i', 'o', 'n', 's', '/', 'v', 'e', 'r', 's', 'i', 'o', 'n', 'i', 'n', 'g', '.', 'p', 'r', 'o', 't', 'o', '\"', '\307', '\001', '\n', 
'\021', 'U', 'd', 'p', 'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', '\022', '*', '\n', '\021', 'u', 'd', 'p', 
'_', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '_', 'n', 'a', 'm', 'e', '\030', '\001', ' ', '\001', '(', '\t', 'R', '\017', 'u', 'd', 'p', 
'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'N', 'a', 'm', 'e', '\022', '9', '\n', '\014', 't', 'y', 'p', 'e', 'd', '_', 'c', 'o', 'n', 
'f', 'i', 'g', '\030', '\003', ' ', '\001', '(', '\013', '2', '\024', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 
'u', 'f', '.', 'A', 'n', 'y', 'H', '\000', 'R', '\013', 't', 'y', 'p', 'e', 'd', 'C', 'o', 'n', 'f', 'i', 'g', ':', '.', '\232', '\305', 
'\210', '\036', ')', '\n', '\'', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 'l', 'i', 's', 't', 'e', 'n', 'e', 
'r', '.', 'U', 'd', 'p', 'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', 'B', '\r', '\n', '\013', 'c', 'o', 
'n', 'f', 'i', 'g', '_', 't', 'y', 'p', 'e', 'J', '\004', '\010', '\002', '\020', '\003', 'R', '\006', 'c', 'o', 'n', 'f', 'i', 'g', '\"', 'U', 
'\n', '\032', 'A', 'c', 't', 'i', 'v', 'e', 'R', 'a', 'w', 'U', 'd', 'p', 'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'C', 'o', 'n', 
'f', 'i', 'g', ':', '7', '\232', '\305', '\210', '\036', '2', '\n', '0', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 
'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '.', 'A', 'c', 't', 'i', 'v', 'e', 'R', 'a', 'w', 'U', 'd', 'p', 'L', 'i', 's', 't', 
'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', 'B', 'J', '\n', '&', 'i', 'o', '.', 'e', 'n', 'v', 'o', 'y', 'p', 'r', 'o', 
'x', 'y', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '.', 
'v', '3', 'B', '\026', 'U', 'd', 'p', 'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', 'P', 'r', 'o', 't', 
'o', 'P', '\001', '\272', '\200', '\310', '\321', '\006', '\002', '\020', '\002', 'b', '\006', 'p', 'r', 'o', 't', 'o', '3', 
};

static upb_def_init *deps[4] = {
  &google_protobuf_any_proto_upbdefinit,
  &udpa_annotations_status_proto_upbdefinit,
  &udpa_annotations_versioning_proto_upbdefinit,
  NULL
};

upb_def_init envoy_config_listener_v3_udp_listener_config_proto_upbdefinit = {
  deps,
  layouts,
  "envoy/config/listener/v3/udp_listener_config.proto",
  UPB_STRVIEW_INIT(descriptor, 544)
};
