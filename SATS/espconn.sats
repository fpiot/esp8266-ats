#include "../config.hats"
staload "{$ESP8266}/SATS/ip_addr.sats"

%{#
#ifndef ATS_SATS_ESPCONN
#define ATS_SATS_ESPCONN
#include "ip_addr.h"
#include "espconn.h"

#define ats_espconn_regist_recvcb(E,R) espconn_regist_recvcb(E,(espconn_recv_callback)R)
#define ats_espconn_gethostbyname(E,H,A,F) espconn_gethostbyname(E,H,A,(dns_found_callback)F)
#endif // ifndef ATS_SATS_ESPCONN
%}

typedef err_t = int8

typedef espconn_connect_callback_t = (ptr) -> void
typedef espconn_reconnect_callback_t = (ptr, int8) -> void
typedef espconn_recv_callback_t = (ptr, string, int) -> void
typedef espconn_sent_callback_t = (ptr) -> void
typedef dns_found_callback_t = {l:addr} (!ip_addr_t@l | string, ptr l, ptr) -> void

abst@ype espconn_type = $extype"espconn_type"
macdef ESPCONN_INVALID = $extval(espconn_type, "ESPCONN_INVALID")
macdef ESPCONN_TCP     = $extval(espconn_type, "ESPCONN_TCP")
macdef ESPCONN_UDP     = $extval(espconn_type, "ESPCONN_UDP")
abst@ype espconn_state = $extype"espconn_state"
macdef ESPCONN_NONE    = $extval(espconn_state, "ESPCONN_NONE")
macdef ESPCONN_WAIT    = $extval(espconn_state, "ESPCONN_WAIT")
macdef ESPCONN_LISTEN  = $extval(espconn_state, "ESPCONN_LISTEN")
macdef ESPCONN_CONNECT = $extval(espconn_state, "ESPCONN_CONNECT")
macdef ESPCONN_WRITE   = $extval(espconn_state, "ESPCONN_WRITE")
macdef ESPCONN_READ    = $extval(espconn_state, "ESPCONN_READ")
macdef ESPCONN_CLOSE   = $extval(espconn_state, "ESPCONN_CLOSE")
typedef esp_tcp = $extype_struct"esp_tcp" of {
  remote_port = int
, local_port  = int
, local_ip    = @[uint8][4]
, remote_ip   = @[uint8][4]
, connect_callback    = espconn_connect_callback_t
, reconnect_callback  = espconn_reconnect_callback_t
, disconnect_callback = espconn_connect_callback_t
, write_finish_fn     = espconn_connect_callback_t
}
typedef esp_udp = $extype_struct"esp_udp" of {
  remote_port = int
, local_port  = int
, local_ip    = @[uint8][4]
, remote_ip   = @[uint8][4]
}
typedef espconn_proto_union_t = $extype_struct"union {esp_tcp *tcp; esp_udp *udp;}" of {
  (* xxx Use union as struct! *)
  tcp = cPtr0(esp_tcp)
, udp = cPtr0(esp_udp)
}
typedef espconn_t = $extype_struct"struct espconn" of {
  type  = espconn_type
, state = espconn_state
, proto = espconn_proto_union_t
, recv_callback = espconn_recv_callback_t
, sent_callback = espconn_sent_callback_t
, link_cnt = uint8
, reverse  = ptr
}

macdef ESPCONN_IDLE = $extval(uint8, "ESPCONN_IDLE")
macdef ESPCONN_CLIENT = $extval(uint8, "ESPCONN_CLIENT")
macdef ESPCONN_SERVER = $extval(uint8, "ESPCONN_SERVER")
macdef ESPCONN_BOTH = $extval(uint8, "ESPCONN_BOTH")
macdef ESPCONN_MAX = $extval(uint8, "ESPCONN_MAX")

fun espconn_connect {l:addr} (!espconn_t@l | espconn: ptr l): int8 = "mac#"
fun espconn_disconnect {l:addr} (!espconn_t@l | espconn: ptr l): int8 = "mac#"
fun espconn_sent {l:addr} (!espconn_t@l | espconn: ptr l, psent: ptr, length: uint16): int8 = "mac#"
fun espconn_regist_connectcb {l:addr} (!espconn_t@l | espconn: ptr l, connect_cb: espconn_connect_callback_t): int8 = "mac#"
fun espconn_regist_recvcb {l:addr} (!espconn_t@l | espconn: ptr l, recv_cb: espconn_recv_callback_t): int8 = "mac#ats_espconn_regist_recvcb"
fun espconn_regist_disconcb {l:addr} (!espconn_t@l | espconn: ptr l, discon_cb: espconn_connect_callback_t): int8 = "mac#"
fun espconn_port (): int = "mac#"
fun espconn_gethostbyname {l:addr} (!espconn_t@l | pespconn: ptr l, hostname: string, addr: cPtr1(ip_addr_t), found: dns_found_callback_t): err_t = "mac#ats_espconn_gethostbyname"
fun espconn_secure_connect {l:addr} (!espconn_t@l | espconn: ptr l): int8 = "mac#"
fun espconn_secure_disconnect {l:addr} (!espconn_t@l | espconn: ptr l): int8 = "mac#"
fun espconn_secure_sent {l:addr} (!espconn_t@l | espconn: ptr l, psent: ptr, length: uint16): int8 = "mac#"
fun espconn_secure_set_size (level: uint8, size: uint16): bool = "mac#"
