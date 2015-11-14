#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"

%{#
#include "os_type.h"
#include "user_interface.h"
%}

macdef NULL_MODE      = $extval(uint8, "NULL_MODE")
macdef STATION_MODE   = $extval(uint8, "STATION_MODE")
macdef SOFTAP_MODE    = $extval(uint8, "SOFTAP_MODE")
macdef STATIONAP_MODE = $extval(uint8, "STATIONAP_MODE")

fun system_os_post(prio: uint8, sig: os_signal_t, par: os_param_t): bool = "mac#"
fun wifi_set_opmode_current (opmode: uint8): bool = "mac#"
