%{#
#include "espconn.h"
%}

abst@ype espconn_t = $extype"struct espconn"
typedef espconn_connect_callback_t = (ptr) -> void
typedef espconn_recv_callback_t = (ptr, string, int) -> void

fun espconn_disconnect (espconn: cPtr1(espconn_t)): int8 = "mac#"
fun espconn_regist_recvcb (espconn: cPtr1(espconn_t), recv_cb: espconn_recv_callback_t): int8 = "mac#"
