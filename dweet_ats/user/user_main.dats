#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"
staload "{$ESP8266}/SATS/user_interface.sats"
staload "{$ESP8266}/SATS/espconn.sats"
staload UN = "prelude/SATS/unsafe.sats"

%{^
void tcp_connected( void *arg );
void wifi_callback_c( System_Event_t *evt );
%}
extern fun tcp_connected (ptr): void = "mac#"

extern fun user_rf_pre_init (): void = "mac#"
implement user_rf_pre_init () = ()

extern fun data_received: espconn_recv_callback_t = "mac#"
implement data_received (arg, pdata, len) = {
  val conn = $UN.cast{cPtr1(espconn_t)}(arg)
  val () = println! ("data_received(): ", pdata)
  val _  = espconn_disconnect conn
}

extern fun tcp_disconnected: espconn_connect_callback_t
implement tcp_disconnected (arg) = {
  val () = println! "tcp_disconnected()"
  val _  = wifi_station_disconnect()
}

var dweet_tcp: esp_tcp // xxx should be local

extern fun dns_done: dns_found_callback_t = "mac#"
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
             val (pfat_tcp, pfback_tcp | tcp) = $UN.ptr0_vtake{esp_tcp}(addr@dweet_tcp)
             val () = tcp->local_port := espconn_port ()
             val () = tcp->remote_port := 80
             val () = os_memcpy(addr@(tcp->remote_ip), addr@(ipaddr->addr), 4)
             prval () = pfback_tcp pfat_tcp
             val () = conn->proto.tcp := $UN.cast{cPtr0(esp_tcp)}(addr@dweet_tcp)
             prval () = pfback_conn pfat_conn

             val conn = $UN.cast{cPtr1(espconn_t)}(arg)
             val _ = espconn_regist_connectcb (conn, tcp_connected)
             val _ = espconn_regist_disconcb (conn, tcp_disconnected)
             val _ = espconn_connect conn
           }
}

extern fun wifi_callback_c: wifi_event_handler_cb_t = "mac#"
extern fun wifi_callback: wifi_event_handler_cb_t
implement wifi_callback (evt) = wifi_callback_c evt

extern fun user_init (): void = "mac#"
implement user_init () = {
  val () = uart_div_modify (0, UART_CLK_FREQ / 115200)
  val () = println! "\nuser_init()"

  val _  = wifi_station_set_hostname "dweet"
  val _  = wifi_set_opmode_current STATION_MODE

  val _  = wifi_station_setup ()
  val () = wifi_set_event_handler_cb wifi_callback
}

%{$
struct espconn dweet_conn;
ip_addr_t dweet_ip;

char dweet_host[] = "dweet.io";
char dweet_path[] = "/dweet/for/eccd882c-33d0-11e5-96b7-10bf4884d1f9";
char json_data[ 256 ];
char buffer[ 2048 ];

void tcp_connected( void *arg )
{
    int temperature = 55;   // test data
    struct espconn *conn = arg;
    
    os_printf( "%s\n", __FUNCTION__ );
    espconn_regist_recvcb( conn, (espconn_recv_callback) data_received );

    os_sprintf( json_data, "{\"temperature\": \"%d\" }", temperature );
    os_sprintf( buffer, "POST %s HTTP/1.1\r\nHost: %s\r\nConnection: close\r\nContent-Type: application/json\r\nContent-Length: %d\r\n\r\n%s", 
                         dweet_path, dweet_host, os_strlen( json_data ), json_data );
    
    os_printf( "Sending: %s\n", buffer );
    espconn_sent( conn, buffer, os_strlen( buffer ) );
}

void wifi_callback_c( System_Event_t *evt )
{
    os_printf( "%s: %d\n", __FUNCTION__, evt->event );
    
    switch ( evt->event )
    {
        case EVENT_STAMODE_CONNECTED:
        {
            os_printf("connect to ssid %s, channel %d\n",
                        evt->event_info.connected.ssid,
                        evt->event_info.connected.channel);
            break;
        }

        case EVENT_STAMODE_DISCONNECTED:
        {
            os_printf("disconnect from ssid %s, reason %d\n",
                        evt->event_info.disconnected.ssid,
                        evt->event_info.disconnected.reason);
            
            deep_sleep_set_option( 0 );
            system_deep_sleep( 60 * 1000 * 1000 );  // 60 seconds
            break;
        }

        case EVENT_STAMODE_GOT_IP:
        {
            os_printf("ip:" IPSTR ",mask:" IPSTR ",gw:" IPSTR,
                        IP2STR(&evt->event_info.got_ip.ip),
                        IP2STR(&evt->event_info.got_ip.mask),
                        IP2STR(&evt->event_info.got_ip.gw));
            os_printf("\n");
            
            espconn_gethostbyname( &dweet_conn, dweet_host, &dweet_ip, (dns_found_callback) dns_done );
            break;
        }
        
        default:
        {
            break;
        }
    }
}
%}
