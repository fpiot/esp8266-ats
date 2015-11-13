%{#
#include "ets_sys.h"
#include "gpio.h"
%}

macdef BIT2 = $extval(uint, "BIT2")
macdef GPIO_OUT_ADDRESS  = $extval(int, "GPIO_OUT_ADDRESS")

macdef PERIPHS_IO_MUX_GPIO2_U = $extval(ptr, "PERIPHS_IO_MUX_GPIO2_U")
macdef FUNC_GPIO2 = $extval(uint, "FUNC_GPIO2")

fun GPIO_REG_READ (x: int): uint = "mac#"
fun PIN_FUNC_SELECT (p: ptr, v: uint): void = "mac#"
fun PIN_PULLUP_EN (p: ptr): void = "mac#"

fun gpio_init (): void = "mac#"
fun gpio_output_set (set_mask: uint, clear_mask: uint, enable_mask: uint, disable_mask: uint): void = "mac#"
