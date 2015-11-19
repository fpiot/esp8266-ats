#include "../config.hats"
staload "{$ESP8266}/SATS/osapi.sats"
staload "{$ESP8266}/SATS/ip_addr.sats"

%{#
#ifndef ATS_SATS_USER_INTERFACE
#define ATS_SATS_USER_INTERFACE
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
#endif // ifndef ATS_SATS_USER_INTERFACE
%}

fun system_deep_sleep_set_option (option: uint8): bool = "mac#"
fun system_deep_sleep (time_in_us: uint): void = "mac#"
fun system_os_task (task: os_task_t, prio: uint8, queue: ptr, qlen: uint8): bool = "mac#ats_system_os_task"
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

macdef EVENT_STAMODE_CONNECTED          = $extval(uint32, "EVENT_STAMODE_CONNECTED")
macdef EVENT_STAMODE_DISCONNECTED       = $extval(uint32, "EVENT_STAMODE_DISCONNECTED")
macdef EVENT_STAMODE_AUTHMODE_CHANGE    = $extval(uint32, "EVENT_STAMODE_AUTHMODE_CHANGE")
macdef EVENT_STAMODE_GOT_IP             = $extval(uint32, "EVENT_STAMODE_GOT_IP")
macdef EVENT_STAMODE_DHCP_TIMEOUT       = $extval(uint32, "EVENT_STAMODE_DHCP_TIMEOUT")
macdef EVENT_SOFTAPMODE_STACONNECTED    = $extval(uint32, "EVENT_SOFTAPMODE_STACONNECTED")
macdef EVENT_SOFTAPMODE_STADISCONNECTED = $extval(uint32, "EVENT_SOFTAPMODE_STADISCONNECTED")
macdef EVENT_SOFTAPMODE_PROBEREQRECVED  = $extval(uint32, "EVENT_SOFTAPMODE_PROBEREQRECVED")
macdef EVENT_MAX                        = $extval(uint32, "EVENT_MAX")
typedef Event_StaMode_Connected_t = $extype_struct"Event_StaMode_Connected_t" of {
  ssid     = @[uint8][32]
, ssid_len = uint8
, bssid    = @[uint8][6]
, channel  = uint8
}
typedef Event_StaMode_Disconnected_t = $extype_struct"Event_StaMode_Disconnected_t" of {
  ssid     = @[uint8][32]
, ssid_len = uint8
, bssid    = @[uint8][6]
, reason   = uint8
}
typedef Event_StaMode_AuthMode_Change_t = $extype_struct"Event_StaMode_AuthMode_Change_t" of {
  old_mode = uint8
, new_mode = uint8
}
typedef Event_StaMode_Got_IP_t = $extype_struct"Event_StaMode_Got_IP_t" of {
  ip   = ip_addr_t
, mask = ip_addr_t
, gw   = ip_addr_t
}
typedef Event_SoftAPMode_StaConnected_t = $extype_struct"Event_SoftAPMode_StaConnected_t" of {
  mac = @[uint8][6]
, aid = uint8
}
typedef Event_SoftAPMode_StaDisconnected_t = $extype_struct"Event_SoftAPMode_StaDisconnected_t" of {
  mac = @[uint8][6]
, aid = uint8
}
typedef Event_SoftAPMode_ProbeReqRecved_t = $extype_struct"Event_SoftAPMode_ProbeReqRecved_t" of {
  rssi = int
, mac  = @[uint8][6]
}
typedef Event_Info_u = $extype_struct"Event_Info_u" of {
  (* xxx Use union as struct! *)
  connected         = Event_StaMode_Connected_t
, disconnected      = Event_StaMode_Disconnected_t
, auth_change       = Event_StaMode_AuthMode_Change_t
, got_ip            = Event_StaMode_Got_IP_t
, sta_connected     = Event_SoftAPMode_StaConnected_t
, sta_disconnected  = Event_SoftAPMode_StaDisconnected_t
, ap_probereqrecved = Event_SoftAPMode_ProbeReqRecved_t
}
typedef System_Event_t = $extype_struct"System_Event_t" of {
  event      = uint32
, event_info = Event_Info_u
}

typedef wifi_event_handler_cb_t = {l:addr} (!System_Event_t@l | ptr l) -> void

fun wifi_set_event_handler_cb (cb: wifi_event_handler_cb_t): void = "mac#ats_wifi_set_event_handler_cb"
