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
<#-- @ftlvariable name="query" type="java.lang.String" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<div class="yui-main">
  <div id="content" class="yui-b right more-padding">
    <#if pageable??>
      <h2>Search results</h2>
        <#if pageable.total == 0>
          <p id="results">No results for: ${query}</p>
        <#else>
          <#assign first=pageable.startOffset + 1>
          <p id="results">Displaying ${first} to ${pageable.endOffset} of ${pageable.total} results for '${query}'</p>
          <div id="search-results">
            <#list pageable.items as item>
              <@hst.link var="link" hippobean=item />
              <ul class="search-result">
                <li class="title"><a href="${link}">${item.title}</a></li>
                <li class="text">${item.introduction}</li>
              </ul>
            </#list>
          </div>
        <#if pageable.showPagination??>
          <#include "/WEB-INF/freemarker/include/pagination.ftl">
        </#if>
      </#if>
    <#else>
      <h2>Please fill in a search term.</h2>
    </#if>
  </div>
</div>