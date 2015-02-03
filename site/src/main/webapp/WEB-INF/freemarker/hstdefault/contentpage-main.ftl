    <#include "/WEB-INF/freemarker/include/imports.ftl">
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
<#-- @ftlvariable name="document" type="org.example.beans.ContentDocument" -->

<#if document??>
  <@hst.link var="link" hippobean=document/>
  <div class="yui-main">
    <div id="content" class="yui-b left-and-right">
      <div id="article" class="about ">
        <@hst.cmseditlink hippobean=document/>
        <h2 class="title">${document.title}</h2>
        <#if document.introduction??>
          <p class="intro">${document.introduction}</p>
        </#if>
        <div class="yui-cssbase body">
          <@hst.html hippohtml=document.content/>
        </div>
      </div>
    </div>
  </div>
</#if>