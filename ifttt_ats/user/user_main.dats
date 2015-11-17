#include "../config.hats"
#include "share/atspre_staload.hats"
staload "{$ESP8266}/SATS/osapi.sats"
staload "{$ESP8266}/SATS/user_interface.sats"
staload "{$ESP8266}/SATS/ip_addr.sats"
staload "{$ESP8266}/SATS/espconn.sats"
staload UN = "prelude/SATS/unsafe.sats"

staload "{$ESP8266}/SATS/tostring.sats"
staload _ = "{$ESP8266}/TDATS/tostring.dats"

%{^
char ifttt_host[] = "maker.ifttt.com";
char ifttt_path[] = IFTTT_PATH;

void tcp_connected_c( void *arg );
%}
extern val ifttt_host: string = "mac#"
extern val ifttt_path: string = "mac#"

extern fun user_rf_pre_init (): void = "mac#"
implement user_rf_pre_init () = ()

extern fun data_received: espconn_recv_callback_t
implement data_received (arg, pdata, len) = {
  val conn = $UN.cast{cPtr1(espconn_t)}(arg)
  val () = println! ("data_received(): ", pdata)
  val _  = espconn_disconnect conn
}

extern fun tcp_connected_c (ptr): void = "mac#"
extern fun tcp_connected (ptr): void
local
  var buffer: @[char][2048]
in
  implement tcp_connected (arg) = {
    val temperature = 55 (* test data *)
    val conn = $UN.cast{cPtr1(espconn_t)}(arg)

    val () = println! "tcp_connected()"
    val _  = espconn_regist_recvcb (conn, data_received)

    // xxx need to make JSON library
    val json_open = string0_copy "{\"value1\": \""
    val json_close = string0_copy "\" }"
    val temp = esp_tostrptr_int temperature
    val json_head = strptr_append (json_open, temp)
    val json_data = strptr_append (json_head, json_close)
    val () = (free json_open; free json_close; free temp; free json_head)

    // xxx need to make JSON-sender function
    extern fun os_sprint_jsonpost (ptr, string, string, string, ssize_t, !Strptr0): void = "mac#os_sprintf" // xxx unsafe
    val () = os_sprint_jsonpost (addr@buffer, "POST %s HTTP/1.1\r\nHost: %s\r\nConnection: close\r\nContent-Type: application/json\r\nContent-Length: %d\r\n\r\n%s", ifttt_path, ifttt_host, length json_data, json_data)
    val () = println! ("Sending: ", ($UN.cast{string}(addr@buffer)))
    val () = free json_data

    extern fun os_strlen (ptr): uint16 = "mac#" // xxx unsafe
    val _ = espconn_sent(conn, addr@buffer, os_strlen(addr@buffer))
  }
end

extern fun tcp_disconnected: espconn_connect_callback_t
implement tcp_disconnected (arg) = {
  val () = println! "tcp_disconnected()"
  val _  = wifi_station_disconnect()
}

extern fun dns_done: dns_found_callback_t
local
  var ifttt_tcp: esp_tcp
in
  implement dns_done (pfat | name, ipaddr, arg) = {
    extern fun os_memcpy (ptr, ptr, int): void = "mac#" // xxx unsafe
    val () = println! "dns_done()"
    val () = if ipaddr = the_null_ptr then {
               val () = println! "DNS lookup failed"
               val _  = wifi_station_disconnect ()
             } else {
               val () = println! "Connecting..."

               val (pfat_conn, pfback_conn | conn) = $UN.ptr_vtake{espconn_t}(arg)
               val () = conn->type := ESPCONN_TCP
               val () = conn->state := ESPCONN_NONE
               val (pfat_tcp, pfback_tcp | tcp) = $UN.ptr0_vtake{esp_tcp}(addr@ifttt_tcp)
               val () = tcp->local_port := espconn_port ()
               val () = tcp->remote_port := 80
               val () = os_memcpy(addr@(tcp->remote_ip), addr@(ipaddr->addr), 4)
               prval () = pfback_tcp pfat_tcp
               val () = conn->proto.tcp := $UN.cast{cPtr0(esp_tcp)}(addr@ifttt_tcp)
               prval () = pfback_conn pfat_conn

               val conn = $UN.cast{cPtr1(espconn_t)}(arg)
               val _ = espconn_regist_connectcb (conn, tcp_connected)
               val _ = espconn_regist_disconcb (conn, tcp_disconnected)
               val _ = espconn_connect conn
             }
  }
end

extern fun wifi_callback: wifi_event_handler_cb_t
local
  var ifttt_conn: espconn_t
  var ifttt_ip: ip_addr_t
in
  implement wifi_callback (pfat | evt) = {
    val () = println! ("wifi_callback(): ", evt->event)
    val () = case+ 0 of
             | _ when evt->event = EVENT_STAMODE_CONNECTED => {
                 val ssid_str = $UN.cast{string}(addr@(evt->event_info.connected.ssid))
                 val () = print "connect to ssid "
                 val () = print ssid_str
                 val () = println! (", channel ", evt->event_info.connected.channel)
               }
             | _ when evt->event = EVENT_STAMODE_DISCONNECTED => {
                 val ssid_str = $UN.cast{string}(addr@(evt->event_info.disconnected.ssid))
                 val () = print "disconnect to ssid "
                 val () = print ssid_str
                 val () = println! (", reason ", evt->event_info.disconnected.reason)

                 val _  = system_deep_sleep_set_option ($UN.cast{uint8}(0))
                 val () = system_deep_sleep (60U * 1000U * 1000U) (* 60 seconds *)
               }
             | _ when evt->event = EVENT_STAMODE_GOT_IP => {
                 val () = println! ("ip:", evt->event_info.got_ip.ip
                                   ,",mask:", evt->event_info.got_ip.mask
                                   ,",gw:", evt->event_info.got_ip.gw)
                 val _ = espconn_gethostbyname ($UN.cast{cPtr1(espconn_t)}(addr@ifttt_conn), ifttt_host,
                                                $UN.cast{cPtr1(ip_addr_t)}(addr@ifttt_ip), dns_done)
               }
             | _ => ()
  }
end

extern fun user_init (): void = "mac#"
implement user_init () = {
  val () = uart_div_modify (0, UART_CLK_FREQ / 115200)
  val () = println! "\nuser_init()"

  val _  = wifi_station_set_hostname "ifttt"
  val _  = wifi_set_opmode_current STATION_MODE

  val _  = wifi_station_setup ()
  val () = wifi_set_event_handler_cb wifi_callback
}
