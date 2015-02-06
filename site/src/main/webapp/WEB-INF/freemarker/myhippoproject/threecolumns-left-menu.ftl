<#include "/WEB-INF/freemarker/include/imports.ftl">
<#if menu??>
<div id="left" class="yui-b">
    <#if menu.siteMenuItems??>
        <#list menu.siteMenuItems as item>
            <#if item.selected || item.expanded>
                <!-- leftmenu -->
                <ul id="left-nav">
                    <#list item.childMenuItems as item>
                        <li><a href="<@hst.link link=item.hstLink/>">${item.name}</a></li>
                    </#list>
                </ul>
            </#if>
        </#list>
    </#if>
</div>
</#if>