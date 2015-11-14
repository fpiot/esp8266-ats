%{#
#include "osapi.h"
#include "os_type.h"
%}

typedef  os_signal_t = uint
typedef  os_param_t  = uint
abst@ype os_event_t  = $extype"os_event_t"
typedef  os_task_t   = cPtr0(os_event_t) -> void
abst@ype os_timer_t  = $extype"os_timer_t"
typedef  os_timer_func_t = ptr -> void

macdef UART_CLK_FREQ = $extval(int, "UART_CLK_FREQ")

fun os_delay_us (us: uint): void = "mac#"
fun os_timer_arm (ptimer: cPtr1(os_timer_t), ms: uint, repeat_flag: bool): void = "mac#"
fun os_timer_disarm (ptimer: cPtr1(os_timer_t)): void = "mac#"
fun os_timer_setfn (ptimer: cPtr1(os_timer_t), pfunc: os_timer_func_t, parg: ptr): void = "mac#"
fun uart_div_modify(uart: int, freq: int): void = "mac#"
