#include "../config.hats"
#include "{$ESP8266}/ESP8266_PRELUDE/kernel_staload.hats"
staload "{$ESP8266}/SATS/osapi.sats"
staload "{$ESP8266}/SATS/gpio.sats"
staload UN = "prelude/SATS/unsafe.sats"

extern fun printf_string (x:string): void = "mac#"
implement printf_string (x) = println! x

extern fun user_init_ats (): void = "mac#"
implement user_init_ats () = {
  (* Initialize the GPIO subsystem. *)
  val () = gpio_init ()
  (* Set GPIO2 to output mode *)
  val () = PIN_FUNC_SELECT (PERIPHS_IO_MUX_GPIO2_U, FUNC_GPIO2)
  (* Set GPIO2 low *)
  val () = gpio_output_set (0U, BIT2, BIT2, 0U);
}

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

%{$
#include "os_type.h"
#include "user_interface.h"
#include "user_config.h"

static volatile os_timer_t some_timer;

//Init function 
void ICACHE_FLASH_ATTR
user_init()
{
    uart_div_modify(0, UART_CLK_FREQ / 115200);
    printf_string("\nuser_init() start.");
    wifi_set_opmode_current(NULL_MODE);

    user_init_ats();

    //Disarm timer
    os_timer_disarm(&some_timer);

    //Setup timer
    os_timer_setfn(&some_timer, (os_timer_func_t *)some_timerfunc, NULL);

    //Arm the timer
    //&some_timer is the pointer
    //1000 is the fire time in ms
    //0 for once and 1 for repeating
    os_timer_arm(&some_timer, 1000, 1);
}
%}
