#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"

%{#
#include "os_type.h"
#include "user_interface.h"
#define ats_system_os_task(T,P,Q,L) system_os_task((os_task_t)T,P,Q,L)
%}

fun system_os_task (task: os_task_t, prio: uint8, queue: cPtr1(os_event_t), qlen: uint8): bool = "mac#ats_system_os_task"
fun system_os_post (prio: uint8, sig: os_signal_t, par: os_param_t): bool = "mac#"

macdef NULL_MODE      = $extval(uint8, "NULL_MODE")
macdef STATION_MODE   = $extval(uint8, "STATION_MODE")
macdef SOFTAP_MODE    = $extval(uint8, "SOFTAP_MODE")
macdef STATIONAP_MODE = $extval(uint8, "STATIONAP_MODE")

fun wifi_set_opmode (opmode: uint8): bool = "mac#"
fun wifi_set_opmode_current (opmode: uint8): bool = "mac#"
