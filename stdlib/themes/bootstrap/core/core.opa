/*
    Copyright © 2011, 2012 MLstate

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
*/

/**
 * {1 About this module}
 *
 * This module allows you to use Twitter's Bootstrap style (http://twitter.github.com/bootstrap/) directly in your application.
 * It also includes several sets of icons.
 *
 * {1 Where should I start}
 *
 * If you want to use the latest version, just import this package (stdlib.themes.bootstrap).
 * Otherwise, import stdlib.themes.bootstrap.v{X.Y.Z}.
 * /!\ If the version you are looking for is not embed in Opa, it will reference GitHub's URL.
 *
 * {1 How to use icons}
 *
 * There are different sizes:
 * - to use 16x16 pixels icon, set class "icon"
 * - to use 32x32 pixels icon, set class "icon32"
 * There are different colors:
 * - gray is the default
 * - to use black color, set class "icon-white"
 * - to use white color, set class "icon-black"
 * There are different icons:
 * - triangle (icon-triangle-n,icon-triangle-e, ...)
 * - arrow (icon-arrow-n, icon-arrowthick-n, icon-arrowreturn-se, ...)
 * - icon-plus, icon-minus, icon-close, icon-check, icon-help, icon-notice ...
 */
Bootstrap = {{

  @private
  config = { DynamicResource.default_config with randomize = false }

  @private
  params = {
    expiration={none}
    consumption={unlimited}
    visibility={shared}
  }

  @private
  publish(name, resource) =
    DynamicResource.publish_extend(name, resource, params, config)

  /** Opa resources **/

  @private
  opa_resources = @static_include_directory("stdlib/themes/bootstrap/opa-resources")

  @private
  uri_opa = Map.mapi(publish, opa_resources)

  import_opa_icons() =
    match Map.get("stdlib/themes/bootstrap/opa-resources/css/icons.css", uri_opa)
    {none} -> void
    {some=uri} -> Resource.register_external_css(uri)

  /** Bootstrap resources **/

  @private
  bs_resources = @static_include_directory("stdlib/themes/bootstrap/bs-resources")

  @private
  uri_bs = Map.mapi(publish, bs_resources)

  @private
  compute_version_url(v:string) =
    if String.le(v, "1.2.0") then // Does not work
      "https://raw.github.com/twitter/bootstrap/v{v}/bootstrap-{v}.min.css"
    else if String.le(v, "1.4.0") then
      "http://twitter.github.com/bootstrap/{v}/bootstrap.min.css"
    else
      "http://twitter.github.com/bootstrap/assets/css/bootstrap.css"

  @private
  bs_url(v:string) =
    Map.get("stdlib/themes/bootstrap/bs-resources/{v}/css/bootstrap.min.css", uri_bs) ?
    compute_version_url(v) // fallback

  import_css(v:string) =
    do Resource.register_external_css(bs_url(v))
    if String.lt(v, "2.0.0") then void
    else match Map.get("stdlib/themes/bootstrap/bs-resources/{v}/css/bootstrap-responsive.min.css", uri_bs)
         {some=url} -> Resource.register_external_css(url)
         {none} -> void

  import_icons(v:string) =
    do if String.lt(v, "2.0.0") then void
    do match Map.get("stdlib/themes/bootstrap/bs-resources/{v}/css/bootstrap-glyphicons.min.css", uri_bs)
       {some=url} -> Resource.register_external_css(url)
       {none} -> void
    do match Map.get("stdlib/themes/bootstrap/bs-resources/{v}/css/glyphicons-halflings-white.min.css", uri_bs)
       {some=url} -> Resource.register_external_css(url)
       {none} -> void
    void

  import(v:string) =
    do import_css(v)
    do import_icons(v)
    void

  latest = "2.0.1"

}}
