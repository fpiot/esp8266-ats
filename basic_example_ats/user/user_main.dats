#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"
staload "{$ESP8266}/SATS/user_interface.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define user_procTaskPrio 0

extern fun loop (events: cPtr0(os_event_t)): void
implement loop (events) = {
  val () = println! "Hello"
  val () = os_delay_us(10000U)
  val _  = system_os_post($UN.cast{uint8}(user_procTaskPrio), 0U, 0U)
}

extern fun user_init (): void = "mac#"
local
  #define user_procTaskQueueLen 1
  typedef user_procTaskQueue_t = @[os_event_t][user_procTaskQueueLen]
  var user_procTaskQueue: user_procTaskQueue_t
in
  implement user_init () = {
    val () = uart_div_modify (0, UART_CLK_FREQ / 115200)
    (* Set station mode *)
    val _  = wifi_set_opmode STATION_MODE
    val _  = wifi_station_setup ()
    (* Start os task *)
    val _ = system_os_task (loop, $UN.cast{uint8}(user_procTaskPrio), addr@user_procTaskQueue, $UN.cast{uint8}(user_procTaskQueueLen))
    val _ = system_os_post ($UN.cast{uint8}(user_procTaskPrio), 0U, 0U)
  }
end
