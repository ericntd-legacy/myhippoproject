<#include "/WEB-INF/freemarker/include/imports.ftl">
<#if pageable??>
<div class="yui-main">
    <div id="content" class="yui-b left-and-right">
        <h2>Products</h2>
        <div id="products">
            <#list pageable.items as item>
                <@hst.link var="link" hippobean=item/>
                <ul class="product-item">
                    <#if item.images?? && item.images[0].small??>
                        <@hst.link var="img" hippobean=item.images[0].small />
                        <li class="image">
                            <a href="${link}"><img src="${img}" alt="${item.title}" /></a>
                        </li>
                    </#if>
                    <li class="title"><a href="${link}">${item.title}</a></li>
                    <li class="price"><a href="${link}"><@fmt.formatNumber value="${item.price}" type="currency" /></a> |</li>
                    <#if item.averageRating gt 0.0>
                    <li class="rating stars-${item.averageRating * 10}"><a href="${link}">${item.averageRating}</a></li>
                    </#if>
                    <li class="description">${item.introduction}</li>
                </ul>
            </#list>
        </div>
        <#if pageable.showPagination>
            <#include "/WEB-INF/freemarker/include/pagination.ftl">
        </#if>
    </div>
</div>
</#if>