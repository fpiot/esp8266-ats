/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*) */

/* ****** ****** */

/*
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/fprintf.atxt
** Time of generation: Fri Sep 25 17:09:24 2015
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: September, 2015 *)
*/

/* ****** ****** */

#ifndef ATSLIB_PRELUDE_CATS_FPRINTF
#define ATSLIB_PRELUDE_CATS_FPRINTF
#include "osapi.h"

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_bool (
  atstype_bool x
) {
  int err = 0 ;
  err += os_printf("%s", atspre_bool2string(x)) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_bool] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_bool]
#define atspre_print_bool(x) atspre_fprint_bool((x))
#define atspre_prerr_bool(x) atspre_fprint_bool((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_char
(
  atstype_char c
) {
  int err = 0 ;
  err += os_printf("%c", c) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_char] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_char]
#define atspre_print_char(c) atspre_fprint_char((c))
#define atspre_prerr_char(c) atspre_fprint_char((c))

ATSinline()
atsvoid_t0ype
atspre_fprint_uchar
(
  atstype_uchar c
) {
  atspre_fprint_char ((atstype_char)c) ; return ;
} // end of [atspre_fprint_uchar]
#define atspre_print_uchar(c) atspre_fprint_uchar((c))
#define atspre_prerr_uchar(c) atspre_fprint_uchar((c))

ATSinline()
atsvoid_t0ype
atspre_fprint_schar
(
  atstype_schar c
) {
  atspre_fprint_char ((atstype_char)c) ; return ;
} // end of [atspre_fprint_schar]
#define atspre_print_schar(c) atspre_fprint_schar((c))
#define atspre_prerr_schar(c) atspre_fprint_schar((c))

/* ****** ****** */
  
ATSinline()
atsvoid_t0ype
atspre_fprint_int
(
  atstype_int x
) {
  int err = 0 ;
  err += os_printf("%i", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_int] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_int]
#define atspre_print_int(x) atspre_fprint_int((x))
#define atspre_prerr_int(x) atspre_fprint_int((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_lint
(
  atstype_lint x
) {
  int err = 0 ;
  err += os_printf("%li", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_lint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_lint]
#define atspre_print_lint(x) atspre_fprint_lint((x))
#define atspre_prerr_lint(x) atspre_fprint_lint((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_llint
(
  atstype_llint x
) {
  int err = 0 ;
  err += os_printf("%lli", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_llint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_llint]
#define atspre_print_llint(x) atspre_fprint_llint((x))
#define atspre_prerr_llint(x) atspre_fprint_llint((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ssize
(
  atstype_ssize x
) {
  int err = 0 ;
  err += os_printf("%li", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ssize] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ssize]
#define atspre_print_ssize(x) atspre_fprint_ssize((x))
#define atspre_prerr_ssize(x) atspre_fprint_ssize((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_uint
(
  atstype_uint x
) {
  int err = 0 ;
  err += os_printf("%u", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_uint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_uint]
#define atspre_print_uint(x) atspre_fprint_uint((x))
#define atspre_prerr_uint(x) atspre_fprint_uint((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ulint
(
  atstype_ulint x
) {
  int err = 0 ;
  err += os_printf("%lu", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ulint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ulint]
#define atspre_print_ulint(x) atspre_fprint_ulint((x))
#define atspre_prerr_ulint(x) atspre_fprint_ulint((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ullint
(
  atstype_ullint x
) {
  int err = 0 ;
  err += os_printf("%llu", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ullint] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ullint]
#define atspre_print_ullint(x) atspre_fprint_ullint((x))
#define atspre_prerr_ullint(x) atspre_fprint_ullint((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_size
(
  atstype_size x
) {
  int err = 0 ;
  atstype_ulint x2 = x ;
  err += os_printf("%lu", x2) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_size] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_size]
#define atspre_print_size(x) atspre_fprint_size((x))
#define atspre_prerr_size(x) atspre_fprint_size((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_ptr (
  atstype_ptr x
) {
  int err ;
  err = os_printf("%p", x) ;
  return ;
} // end [atspre_fprint_ptr]
#define atspre_print_ptr(x) atspre_fprint_ptr((x))
#define atspre_prerr_ptr(x) atspre_fprint_ptr((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_float (
  atstype_float x
) {
  int err = 0 ;
  err += os_printf("%f", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_float] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_float]
#define atspre_print_float(x) atspre_fprint_float((x))
#define atspre_prerr_float(x) atspre_fprint_float((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_double (
  atstype_double x
) {
  int err = 0 ;
  err += os_printf("%f", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_double] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_double]
#define atspre_print_double(x) atspre_fprint_double((x))
#define atspre_prerr_double(x) atspre_fprint_double((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_ldouble (
  atstype_ldouble x
) {
  int err = 0 ;
  err += os_printf("%Lf", x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_ldouble] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end [atspre_fprint_ldouble]
#define atspre_print_ldouble(x) atspre_fprint_ldouble((x))
#define atspre_prerr_ldouble(x) atspre_fprint_ldouble((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_intptr
(
  atstype_intptr x
) {
  int err ;
  err = os_printf("%lli", (atstype_llint)x) ;
  return ;
} // end [atspre_fprint_intptr]
#define atspre_print_intptr(x) atspre_fprint_intptr((x))
#define atspre_prerr_intptr(x) atspre_fprint_intptr((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_uintptr
(
  atstype_uintptr x
) {
  int err ;
  err = os_printf("%llu", (atstype_ullint)x) ;
  return ;
} // end [atspre_fprint_uintptr]
#define atspre_print_uintptr(x) atspre_fprint_uintptr((x))
#define atspre_prerr_uintptr(x) atspre_fprint_uintptr((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_int8
(
  atstype_int8 x
) {
  int err ;
  err = os_printf("%i", (atstype_int)x) ;
  return ;
} // end [atspre_fprint_int8]
#define atspre_print_int8(x) atspre_fprint_int8((x))
#define atspre_prerr_int8(x) atspre_fprint_int8((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_int16
(
  atstype_int16 x
) {
  int err ;
  err = os_printf("%i", (atstype_int)x) ;
  return ;
} // end [atspre_fprint_int16]
#define atspre_print_int16(x) atspre_fprint_int16((x))
#define atspre_prerr_int16(x) atspre_fprint_int16((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_int32
(
  atstype_int32 x
) {
  int err ;
  err = os_printf("%li", (atstype_lint)x) ;
  return ;
} // end [atspre_fprint_int32]
#define atspre_print_int32(x) atspre_fprint_int32((x))
#define atspre_prerr_int32(x) atspre_fprint_int32((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_int64
(
  atstype_int64 x
) {
  int err ;
  err = os_printf("%lli", (atstype_llint)x) ;
  return ;
} // end [atspre_fprint_int64]
#define atspre_print_int64(x) atspre_fprint_int64((x))
#define atspre_prerr_int64(x) atspre_fprint_int64((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_uint8
(
  atstype_uint8 x
) {
  int err ;
  err = os_printf("%u", (atstype_uint)x) ;
  return ;
} // end [atspre_fprint_uint8]
#define atspre_print_uint8(x) atspre_fprint_uint8((x))
#define atspre_prerr_uint8(x) atspre_fprint_uint8((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_uint16
(
  atstype_uint16 x
) {
  int err ;
  err = os_printf("%u", (atstype_uint)x) ;
  return ;
} // end [atspre_fprint_uint16]
#define atspre_print_uint16(x) atspre_fprint_uint16((x))
#define atspre_prerr_uint16(x) atspre_fprint_uint16((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_uint32
(
  atstype_uint32 x
) {
  int err ;
  err = os_printf("%lu", (atstype_ulint)x) ;
  return ;
} // end [atspre_fprint_uint32]
#define atspre_print_uint32(x) atspre_fprint_uint32((x))
#define atspre_prerr_uint32(x) atspre_fprint_uint32((x))

ATSinline()
atsvoid_t0ype
atspre_fprint_uint64
(
  atstype_uint64 x
) {
  int err ;
  err = os_printf("%llu", (atstype_ullint)x) ;
  return ;
} // end [atspre_fprint_uint64]
#define atspre_print_uint64(x) atspre_fprint_uint64((x))
#define atspre_prerr_uint64(x) atspre_fprint_uint64((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_string
(
  atstype_string x
) {
  int err = 0 ;
  err += os_printf("%s", (char*)x) ;
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_string] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_string]
#define atspre_print_string(x) atspre_fprint_string((x))
#define atspre_prerr_string(x) atspre_fprint_string((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_stropt
(
  atstype_stropt x
) {
  int err = 0 ;
  if (!x)
  {
    err += os_printf("strnone()") ;
  } else {
    err += os_printf("strsome(%s)", (char*)x) ;
  }
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_stropt] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_stropt]
#define atspre_print_stropt(x) atspre_fprint_stropt((x))
#define atspre_prerr_stropt(x) atspre_fprint_stropt((x))

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_fprint_strptr
(
  atstype_strptr x
) {
  int err = 0 ;
  if (x != 0) {
    err += os_printf("%s", (char*)x) ;
  } else {
    err += os_printf("%s", "(strnull)") ;
  } // end of [if]
/*
  if (err < 0) {
    fprintf(stderr, "exit(ATS): [fprint_strptr] failed.") ; exit(1) ;
  } // end of [if]
*/
  return ;
} // end of [atspre_fprint_strptr]
#define atspre_print_strptr(x) atspre_fprint_strptr((x))
#define atspre_prerr_strptr(x) atspre_fprint_strptr((x))

/* ****** ****** */

#define atspre_fprint_strbuf atspre_fprint_strptr
#define atspre_print_strbuf(x) atspre_fprint_strbuf((x))
#define atspre_prerr_strbuf(x) atspre_fprint_strbuf((x))

/* ****** ****** */

#endif // ifndef ATSLIB_PRELUDE_CATS_FPRINTF

/* ****** ****** */

/* end of [fprintf.cats] */
