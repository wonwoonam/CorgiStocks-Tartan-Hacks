/* This file was generated by upbc (the upb compiler) from the input
 * file:
 *
 *     google/rpc/status.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include <stddef.h>
#if COCOAPODS==1
  #include  "third_party/upb/upb/msg.h"
#else
  #include  "upb/msg.h"
#endif
#if COCOAPODS==1
  #include  "src/core/ext/upb-generated/google/rpc/status.upb.h"
#else
  #include  "google/rpc/status.upb.h"
#endif
#if COCOAPODS==1
  #include  "src/core/ext/upb-generated/google/protobuf/any.upb.h"
#else
  #include  "google/protobuf/any.upb.h"
#endif

#if COCOAPODS==1
  #include  "third_party/upb/upb/port_def.inc"
#else
  #include  "upb/port_def.inc"
#endif

static const upb_msglayout *const google_rpc_Status_submsgs[1] = {
  &google_protobuf_Any_msginit,
};

static const upb_msglayout_field google_rpc_Status__fields[3] = {
  {1, UPB_SIZE(0, 0), 0, 0, 5, 1},
  {2, UPB_SIZE(4, 8), 0, 0, 9, 1},
  {3, UPB_SIZE(12, 24), 0, 0, 11, 3},
};

const upb_msglayout google_rpc_Status_msginit = {
  &google_rpc_Status_submsgs[0],
  &google_rpc_Status__fields[0],
  UPB_SIZE(16, 32), 3, false, 255,
};

#if COCOAPODS==1
  #include  "third_party/upb/upb/port_undef.inc"
#else
  #include  "upb/port_undef.inc"
#endif

