<!doctype html>
<#--
Copyright 2014 Hippo B.V. (http://www.onehippo.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<#include "/WEB-INF/freemarker/include/imports.ftl">
<#--
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <link rel="stylesheet" href="<@hst.link  path="/css/bootstrap.css"/>" type="text/css"/>
  <@hst.defineObjects/>
  <#if hstRequest.requestContext.cmsRequest>
  <link rel="stylesheet" href="<@hst.link  path="/css/cms-request.css"/>" type="text/css"/>
  </#if>
  <@hst.headContributions categoryIncludes="htmlHead" xhtml=true/>
</head>
<body>
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <@hst.include ref="top"/>
        <@hst.include ref="menu"/>
      </div>
    </div>
    <div class="row">
      <@hst.include ref="main"/>
    </div>
    <div class="row">
      <@hst.include ref="footer"/>
    </div>
  </div>
  <@hst.headContributions categoryIncludes="htmlBodyEnd" xhtml=true/>
</body>
</html>
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

  <title>Hippo Go Green - Home</title>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

  <link rel="stylesheet" media="screen" type="text/css" href="<@hst.link path="/css/style.css"/>" />
  <link rel="stylesheet" media="screen" type="text/css" href="<@hst.link path="/css/yui-css.css"/>" />
  <link rel="stylesheet" media="screen" type="text/css" href="<@hst.link path="/css/screen.css"/>" />

  <link rel="icon" href="<@hst.link path="/images/favicon.ico"/>" type="image/x-icon" />
  <link rel="shortcut icon" href="<@hst.link path="/images/favicon.ico"/>" type="image/x-icon" />
  <link rel="apple-touch-icon" href="<@hst.link path="/images/apple-touch-icon.png"/>" />

  <link rel="alternate" type="application/rss+xml" title="Hippo Go Green RSS" href="<@hst.link path="/rss"/>" />

  <@hst.headContributions categoryIncludes="componentsCss" xhtml=true/>
  <@hst.headContributions categoryIncludes="globalJavascript" xhtml=true/>
</head>

<body>
  <!-- document wrapper -->
  <testing>
  <div id="doc" class="yui-d-custom">
    <div id="wrapper">
      <div id="wrapper2">
        <!-- header -->

        <!-- header -->
        <div id="hd">

          <!-- logo -->
          <h1>
            <a href="#"><img src="<@hst.link path="images/hippo-go-green.png"/>" alt="Hippo Go Green" class="logo" width="275"
              height="70" /></a>
            </h1>

            <!-- search bar -->
            <!-- search bar -->
            <div id="search">
              <form id="searchSubmit" action="<@hst.link siteMapItemRefId="search" />" method="get"
              onsubmit="sanitizeRequestParam(document.forms['searchSubmit']['query'], 'Search')" />
              <p>
                <input class="search-field gray" type="text" name="query" value="Search" /> <input type="submit"
                value="Search" class="search-button" />
              </p>
            </form>
          </div>

          <!--  language navigation -->
          <!-- lang navigation -->
          <ul id="language">
            <li class="staticlabel">Edition:</li>
            <li class="active">United States</li>
            <li class="last"><a href="fr.html">France</a></li>
          </ul>
          <!-- main navigation -->
          <!-- main navigation -->

          <@hst.include ref="menu"/>

        </div>
        <!-- body / main -->
        <div id="bd" class="yui-t1">
          <@hst.include ref="main"/>
        </div><!-- End of #bd -->

        <!-- footer -->
        <@hst.include ref="footer"/>
        </div>
      </div>
    </div>

    <script src="<@hst.link path="js/jquery-2.1.0.min.js"/>" type="text/javascript"></script>
    <script src="<@hst.link path="js/js-common.js"/>" type="text/javascript"></script>
    <@hst.headContributions categoryIncludes="componentsJavascript" xhtml=true/>
  </body>
</html>
