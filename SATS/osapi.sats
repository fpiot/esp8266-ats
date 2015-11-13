%{#
#include "osapi.h"
%}

macdef UART_CLK_FREQ = $extval(int, "UART_CLK_FREQ")

fun os_delay_us (us: uint16): void = "mac#"
fun uart_div_modify(uart: int, freq: int): void = "mac#"
