<#include "/WEB-INF/freemarker/include/imports.ftl">
<#if facets??>
<div id="right" class="yui-b">
    <ul class="box-general" id="filter">
        <#list facets.folders as facet>
            <li class="filter-by">${facet.name}:
                <ul class="bullet-points">
                    <#list facet.folders as value>
                        <#if value.leaf>
                            <@hst.facetnavigationlink var="link" remove=value current=facets />
                            <li><a class="filter" href="${link}">${value.name}</a></li>
                        <#else>
                            <@hst.link var="link" hippobean=value />
                            <li><a href="${link}">${value.name}</a>&nbsp;(${value.count})</li>
                        </#if>
                    </#list>
                </ul>
            </li>
        </#list>
    </ul>
</div>
</#if>