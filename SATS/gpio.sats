%{#
#include "ets_sys.h"
#include "gpio.h"
%}

macdef BIT2 = $extval(uint32, "BIT2")

macdef PERIPHS_IO_MUX_GPIO2_U = $extval(ptr, "PERIPHS_IO_MUX_GPIO2_U")
macdef FUNC_GPIO2 = $extval(uint32, "FUNC_GPIO2")

fun PIN_FUNC_SELECT (p: ptr, v: uint32): void = "mac#"
fun PIN_PULLUP_EN (p: ptr): void = "mac#"

fun gpio_init (): void = "mac#"
fun gpio_output_set (set_mask: uint32, clear_mask: uint32, enable_mask: uint32, disable_mask: uint32): void = "mac#"
