/*
    Copyright © 2011, 2012 MLstate

    This file is part of OPA.

    OPA is free software: you can redistribute it and/or modify it under the
    terms of the GNU Affero General Public License, version 3, as published by
    the Free Software Foundation.

    OPA is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for
    more details.

    You should have received a copy of the GNU Affero General Public License
    along with OPA.  If not, see <http://www.gnu.org/licenses/>.
*/

/**
 * {1 About this module}
 *
 *  It contains several known implementation specific limits.
 *
 */

Limits = {{
  /**
   * The largest integer usable in OPA
   *
   * Note that the size of integers is dictated both by server limitations (64-bit servers have larger integers than 32-bit servers)
   * and by client limitations (JavaScript implementations are typically limited to 53-bit integers).
   */
  max_int = server_max_int

  /**
   * The smallest integer usable in OPA
   *
   * Note that the size of integers is dictated both by server limitations (64-bit servers have larger integers than 32-bit servers)
   * and by client limitations (JavaScript implementations are typically limited to 53-bit integers).
   */
  min_int = -max_int

  @private
  @publish
  server_max_int = %% BslNumber.Int.max_int %% : int
}}
