#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"
staload "{$ESP8266}/SATS/user_interface.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define user_procTaskPrio 0

%{
#define user_procTaskQueueLen 1
os_event_t user_procTaskQueue[user_procTaskQueueLen];
%}
macdef user_procTaskQueue = $extval(cPtr1(os_event_t), "(user_procTaskQueue)")
macdef user_procTaskQueueLen = $extval(uint8, "user_procTaskQueueLen")

extern fun loop (events: cPtr0(os_event_t)): void = "mac#"
implement loop (events) = {
  val () = println! "Hello"
  val () = os_delay_us($UN.cast{uint16}(100000000))
  val _  = system_os_post($UN.cast{uint8}(user_procTaskPrio), 0U, 0U)
}

extern fun user_init_ats (): void = "mac#"
implement user_init_ats () = {
  (* Start os task *)
  val _ = system_os_task (loop, $UN.cast{uint8}(user_procTaskPrio), user_procTaskQueue, user_procTaskQueueLen)
  val _ = system_os_post ($UN.cast{uint8}(user_procTaskPrio), 0U, 0U)
}

%{$
//Init function 
void ICACHE_FLASH_ATTR
user_init()
{
    char ssid[32] = SSID;
    char password[64] = SSID_PASSWORD;
    struct station_config stationConf;

    uart_div_modify(0, UART_CLK_FREQ / 115200);

    //Set station mode
    wifi_set_opmode( 0x1 );

    //Set ap settings
    os_memcpy(&stationConf.ssid, ssid, 32);
    os_memcpy(&stationConf.password, password, 64);
    wifi_station_set_config(&stationConf);

    user_init_ats();
}
%}
