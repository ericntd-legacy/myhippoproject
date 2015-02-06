<#include "/WEB-INF/freemarker/include/imports.ftl">
<#if pageable??>
<div id="content" class="home">
    <div id="home-products">
        <h2 class="go-green">Products</h2>
        <#list pageable.items as item>
            <@hst.link var="link" hippobean=item/>
            <ul class="product-item first ">
                <#if item.images?? && item.images[0]??>
                    <@hst.link var="img" hippobean=item.images[0].small/>
                    <li class="image">
                        <a href="${link}">
                            <img src="${img}" alt="${item.images[0].fileName}" />
                        </a>
                    </li>
                </#if>
                <li class="title"><a href="${link}">${item.title}</a></li>
                <li class="price"><a href="${link}"><@fmt.formatNumber value="${item.price}" type="currency" /></a></li>
                <li class="rating stars-${item.averageRating * 10}"><a href="${link}">${item.averageRating}</a></li>
            </ul>
        </#list>
        <div class="clear"></div>
    </div>
</div>
</#if>