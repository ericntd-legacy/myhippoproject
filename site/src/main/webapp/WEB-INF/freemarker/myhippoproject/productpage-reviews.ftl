<#include "/WEB-INF/freemarker/include/imports.ftl">

<ul id="document-actions">
    <li><a class="comment" href="#review">Review</a></li>
</ul>

<div id="comments">
<#if pageable??>
    <#list pageable.items as item>
        <@hst.link var="link" hippobean=item/>
        <ul class="comment-item">
            <li class="name">${item.name}</li>
            <li class="date"><span class="seperator">|</span>
                <@fmt.formatDate value=item.date.time type="both" dateStyle="medium" timeStyle="short"/>
            </li>
            <li class="text">
                <ul>
                    <li class="score">Score:</li>
                    <li class="rating stars-${item.rating * 10}"></li>
                    <li class="review">${item.comment}</li>
                </ul>
            </li>
            <li class="bg-bottom"></li>
        </ul>
    </#list>
    <#if pageable.showPagination??>
        <#include "/WEB-INF/freemarker/include/pagination.ftl">
    </#if>
</#if>
</div>

<div id="article-footer">
    <h3>Review this article</h3>
    <ul class="box-bottom box-form" id="review">
        <li class="content">
        <@hst.actionURL var="actionUrl"/>
            <form id="frmRating"
                  action="${actionUrl}#frmRating"
                  method="post">
                <table>
                <#if success??>
                    <tr>
                        <td colspan="2">Thank you for reviewing this product. Your review is awaiting approval by a moderator.</td>
                    </tr>
                </#if>
                    <tr>
                        <td class="label">Name</td>
                        <td class="input">
                            <input type="text" value="${name}" name="name" />
                        <#if errors['name']??>
                            <span class="form-error">${errors['name']}</span>
                        </#if>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">Email</td>
                        <td class="input">
                            <input type="text" value="${email}" name="email" />
                        <#if errors['email']??>
                            <span class="form-error">${errors['email']}</span>
                        </#if>
                        </td>
                    </tr>
                    <tr>
                        <td class="label vtop">Score</td>
                        <td class="input">
                            <ol class="rate">
                                <li <#if rating &gt; 0>class="on"</#if>><span title="Rate: 1">1</span></li>
                                <li <#if rating &gt; 1>class="on"</#if>><span title="Rate: 2">2</span></li>
                                <li <#if rating &gt; 2>class="on"</#if>><span title="Rate: 3">3</span></li>
                                <li <#if rating &gt; 3>class="on"</#if>><span title="Rate: 4">4</span></li>
                                <li <#if rating &gt; 4>class="on"</#if>><span title="Rate: 5">5</span></li>
                            </ol> <input type="hidden" value="${rating}"
                                         name="rating" id="ratingField" />
                        <#if errors['rating']??>
                            <span class="form-error">${errors['rating']}</span>
                        </#if>
                        </td>
                    </tr>
                    <tr>
                        <td class="label vtop">Review</td>
                        <td class="input">
                            <textarea name="comment" id="comment" rows="8" cols="50">${comment}</textarea>
                        <#if errors['comment']??>
                            <span class="form-error">${errors['comment']}</span>
                        </#if>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="submit fright"><input
                                type="submit" value="Send"
                                id="comment-button" /></td>
                    </tr>
                </table>
            </form>
        </li>
    </ul>
</div>

<@hst.headContribution keyHint="rate" category="componentsJavascript">
    <@hst.link path="/js/rate.js" var="rateJs"/>
<script type="text/javascript" src="${rateJs}"></script>
</@hst.headContribution>