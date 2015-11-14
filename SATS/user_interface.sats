#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"

%{#
#include "os_type.h"
#include "user_interface.h"
#define ats_system_os_task(T,P,Q,L) system_os_task((os_task_t)T,P,Q,L)
#define ats_wifi_set_event_handler_cb(H) wifi_set_event_handler_cb((wifi_event_handler_cb_t)H)

ATSinline()
atstype_bool
wifi_station_setup(atsvoid_t0ype)
{
  char ssid[32] = SSID;
  char password[64] = SSID_PASSWORD;
  struct station_config stationConf;

  /* Set ap settings */
  stationConf.bssid_set = 0;
  os_memcpy(&stationConf.ssid, ssid, 32);
  os_memcpy(&stationConf.password, password, 64);
  return wifi_station_set_config(&stationConf);
}
%}

fun system_os_task (task: os_task_t, prio: uint8, queue: cPtr1(os_event_t), qlen: uint8): bool = "mac#ats_system_os_task"
fun system_os_post (prio: uint8, sig: os_signal_t, par: os_param_t): bool = "mac#"

macdef NULL_MODE      = $extval(uint8, "NULL_MODE")
macdef STATION_MODE   = $extval(uint8, "STATION_MODE")
macdef SOFTAP_MODE    = $extval(uint8, "SOFTAP_MODE")
macdef STATIONAP_MODE = $extval(uint8, "STATIONAP_MODE")

fun wifi_set_opmode (opmode: uint8): bool = "mac#"
fun wifi_set_opmode_current (opmode: uint8): bool = "mac#"
fun wifi_station_disconnect (): bool = "mac#"

fun wifi_station_setup (): bool = "mac#"
fun wifi_station_set_hostname (name: string): bool = "mac#"

abst@ype System_Event_t = $extype"System_Event_t"
typedef wifi_event_handler_cb_t = cPtr0(System_Event_t) -> void

fun wifi_set_event_handler_cb (cb: wifi_event_handler_cb_t): void = "mac#ats_wifi_set_event_handler_cb"
