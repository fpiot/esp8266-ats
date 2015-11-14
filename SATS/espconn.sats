%{#
#include "ip_addr.h"
#include "espconn.h"
%}

typedef ip_addr_t = $extype_struct"ip_addr_t" of { addr= uint32 }

abst@ype espconn_t = $extype"struct espconn"
typedef espconn_connect_callback_t = (ptr) -> void
typedef espconn_recv_callback_t = (ptr, string, int) -> void
typedef dns_found_callback_t = {l:addr} (!ip_addr_t@l | string, ptr l, ptr) -> void

fun espconn_disconnect (espconn: cPtr1(espconn_t)): int8 = "mac#"
fun espconn_regist_recvcb (espconn: cPtr1(espconn_t), recv_cb: espconn_recv_callback_t): int8 = "mac#"
