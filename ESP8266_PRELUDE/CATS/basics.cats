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
** $PATSHOME/prelude/CATS/CODEGEN/basics.atxt
** Time of generation: Sat Sep 19 23:55:04 2015
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: January, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_PRELUDE_CATS_BASICS
#define ATSLIB_PRELUDE_CATS_BASICS
#include "osapi.h"

/* ****** ****** */

ATSinline()
atstype_int
atspre_lor_int_int
(
  atstype_int x1
, atstype_int x2
) {
  return ((x1)|(x2)) ;
} /* [atspre_lor_int_int] */

ATSinline()
atstype_int
atspre_land_int_int
(
  atstype_int x1
, atstype_int x2
) {
  return ((x1)&(x2)) ;
} /* [atspre_land_int_int] */

ATSinline()
atstype_int
atspre_lxor_int_int
(
  atstype_int x1
, atstype_int x2
) {
  return ((x1)^(x2)) ;
} /* [atspre_lxor_int_int] */

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atspre_cloptr_free
(
  atstype_cloptr pclo
) {
  ATS_MFREE (pclo) ; return ;
} /* [atspre_cloptr_free] */

/* ****** ****** */

ATSinline()
atstype_string
atspre_argv_get_at
(
  atstype_arrptr argv, atstype_int i
)
{
  return (((atstype_string*)argv)[i]) ;
} /* end of [atspre_argv_get_at] */

ATSinline()
atsvoid_t0ype
atspre_argv_set_at
(
  atstype_arrptr argv
, atstype_int i, atstype_string x
)
{
  ((atstype_string*)argv)[i] = x ; return ;
} /* end of [atspre_argv_set_at] */

/* ****** ****** */
//
ATSinline()
atsvoid_t0ype
atspre_fprint_newline
  (void)
{
  os_printf("\n") ;
  return ;
} /* endfun */
//
#define atspre_print_newline() atspre_fprint_newline()
#define atspre_prerr_newline() atspre_fprint_newline()
//
/* ****** ****** */

#endif // ifndef ATSLIB_PRELUDE_CATS_BASICS

/* ****** ****** */

/* end of [basics.cats] */