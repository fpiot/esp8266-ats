%{#
#ifndef ATS_SATS_IP_ADDR
#define ATS_SATS_IP_ADDR
#include "ip_addr.h"

ATSinline()
atsvoid_t0ype
ats_print_ipaddr (
  ip_addr_t ipaddr
) {
  os_printf(IPSTR, IP2STR(&ipaddr));
  return ;
}
#endif // ifndef ATS_SATS_IP_ADDR
%}

typedef ip_addr_t = $extype_struct"ip_addr_t" of { addr= uint32 }

fun print_ipaddr (ip: ip_addr_t): void = "mac#ats_print_ipaddr"
overload print with print_ipaddr
