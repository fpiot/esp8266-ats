#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"
staload "{$ESP8266}/SATS/gpio.sats"
staload "{$ESP8266}/SATS/user_interface.sats"
staload UN = "prelude/SATS/unsafe.sats"

%{
static volatile os_timer_t some_timer;
%}
macdef some_timer_p = $extval(cPtr1(os_timer_t), "(&some_timer)")

extern fun some_timerfunc (arg: ptr): void = "mac#"
implement some_timerfunc (arg) = {
  val () = println! "some_timerfunc() called."
  (* Do blinky stuff *)
  val v = GPIO_REG_READ(GPIO_OUT_ADDRESS) land BIT2
  val () = if v != 0 then
             (* Set GPIO2 to LOW *)
             gpio_output_set (0U, BIT2, BIT2, 0U)
           else
             (* Set GPIO2 to HIGH *)
             gpio_output_set (BIT2, 0U, BIT2, 0U)
}

extern fun user_init_ats (): void = "mac#"
implement user_init_ats () = {
  val () = uart_div_modify(0, UART_CLK_FREQ / 115200)
  val () = println! "\nuser_init() start."
  val _  = wifi_set_opmode_current NULL_MODE
  (* Initialize the GPIO subsystem. *)
  val () = gpio_init ()
  (* Set GPIO2 to output mode *)
  val () = PIN_FUNC_SELECT (PERIPHS_IO_MUX_GPIO2_U, FUNC_GPIO2)
  (* Set GPIO2 low *)
  val () = gpio_output_set (0U, BIT2, BIT2, 0U);
  (* Disarm timer *)
  val () = os_timer_disarm some_timer_p
  (* Setup timer *)
  val () = os_timer_setfn (some_timer_p, some_timerfunc, the_null_ptr)
  (* Arm the timer
     &some_timer is the pointer
     1000 is the fire time in ms
     0 for once and 1 for repeating *)
  val () = os_timer_arm (some_timer_p, 1000U, true)
}

%{$
//Init function 
void ICACHE_FLASH_ATTR
user_init()
{
    user_init_ats();
}
%}
