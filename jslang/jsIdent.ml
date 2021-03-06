(*
    Copyright © 2011 MLstate

    This file is part of OPA.

    OPA is free software: you can redistribute it and/or modify it under the
    terms of the GNU Affero General Public License, version 3, as published by
    the Free Software Foundation.

    OPA is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
    more details.

    You should have received a copy of the GNU Affero General Public License
    along with OPA. If not, see <http://www.gnu.org/licenses/>.
*)
module Hashtbl = BaseHashtbl
module String = BaseString

(* -- *)

type native_ident = [ `global | `local ]

type t =
  | ExprIdent of Ident.t
  | Native of native_ident * string

let compare_native n1 n2 =
  if n1 = `local
  then
    match n2 with
    | `local -> 0
    | `global -> -1
  else
    match n2 with
    | `local -> 1
    | `global -> 0

let compare i1 i2 =
  match i1, i2 with
  | Native (n1, s1), Native (n2, s2) ->
      let res = compare_native n1 n2 in
      if res <> 0 then res
      else
        String.compare s1 s2
  | Native _, ExprIdent _ -> -1
  | ExprIdent _, Native _ -> 1
  | ExprIdent i1, ExprIdent i2 -> Ident.compare i1 i2
let equal i1 i2 =
  match i1, i2 with
  | Native (n1, s1), Native (n2, s2) -> n1 = n2 && String.equal s1 s2
  | ExprIdent i1, ExprIdent i2 -> Ident.equal i1 i2
  | Native _, ExprIdent _
  | ExprIdent _, Native _ -> false
let to_string = function
  | Native (_, s) -> s
  | ExprIdent s -> Ident.to_string s
let hash = function
  | Native (n, s) -> Hashtbl.combine (Hashtbl.hash n) (Hashtbl.hash s)
  | ExprIdent s -> Ident.hash s
let stident = function
  | Native (_, s) -> s
  | ExprIdent s -> Ident.stident s
