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
<#-- @ftlvariable name="document" type="org.example.beans.NewsDocument" -->

<#if document??>
  <@hst.link var="link" hippobean=document/>

  <div class="yui-main">
    <div id="content" class="yui-b left-and-right ">

      <h2>${document.title}</h2>

      <@hst.cmseditlink hippobean=document/>

      <div id="article">

        <#if document.image?? && document.image.large??>
          <@hst.link var="img" hippobean=document.image.large/>
          <img class="image" src="${img}" alt="${document.image.fileName}" />
        </#if>

        <#if document.date??>
          <span class="date"><@fmt.formatDate value=document.date.time type="both" dateStyle="medium" timeStyle="short"/></span>
        </#if>

        <div id="editable_cont" class="inline-editor-editable-container">
          <p>${document.introduction}</p>
          <div class="yui-cssbase body">
            <span class=" inline" id="hippogogreen:description">
              <@hst.html hippohtml=document.content/>
            </span>
          </div>
        </div>

      </div>
    </div>
  </div>

</#if>