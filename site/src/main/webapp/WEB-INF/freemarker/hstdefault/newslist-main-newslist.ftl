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
<#-- @ftlvariable name="item" type="org.example.beans.NewsDocument" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<p>testing</p>
<#if pageable??>
  <div class="yui-main">
    <div id="content" class="yui-b left-and-right">
      <h2>News Overview</h2>
      <div id="news">
        <#list pageable.items as item>
          <@hst.link var="link" hippobean=item />
          <ul class="news-item ">
            <#if item.image?? && item.image.small??>
              <@hst.link var="img" hippobean=item.image.small />
              <li class="image"><a href="${link}"><img
                  src="${img}"
                  alt="${item.title}" /></a></li>
            </#if>
            <li class="title"><a href="${link}">${item.title}</a></li>
            <#if item.date?? && item.date.time??>
              <li class="date"><a href="${link}"><@fmt.formatDate value=item.date.time type="both" dateStyle="medium" timeStyle="short"/></a></li>
            </#if>
            <!--<li class="comments"><a href="${link}"> No comments</a></li>-->
            <li class="description">${item.introduction}</li>
          </ul>
        </#list>
      </div>
      <#if pageable.showPagination??>
        <#include "/WEB-INF/freemarker/include/pagination.ftl">
      </#if>
    </div>
  </div>
</#if>


