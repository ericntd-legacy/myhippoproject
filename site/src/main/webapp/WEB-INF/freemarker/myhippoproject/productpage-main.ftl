<#include "/WEB-INF/freemarker/include/imports.ftl">

<#if document??>
    <@hst.link var="link" hippobean=document/>
<div class="yui-main">
    <div id="content" class="yui-b left-and-right">
        <div>
            <@hst.cmseditlink hippobean=document/>
            <h2>${document.title}</h2>

            <div id="product" class="product-item">
                <#if document.images??>
                    <div class="clear">
                        <ul id="gallery">
                            <#list document.images as item>
                                <@hst.link var="img" hippobean=item/>
                                <li>
                                    <img src="${img}" alt="${item.fileName}"/>
                                </li>
                            </#list>
                        </ul>
                    </div>
                </#if>
                <#if document.date??>
                    <span class="date"><@fmt.formatDate value=document.date.time type="both" dateStyle="medium" timeStyle="short"/></span>
                </#if>
                <p class="info">
                    <span class="price"><@fmt.formatNumber value="${document.price}" type="currency" /></span>
                    <span class="seperator"></span>
                    <span class="rating stars-${document.averageRating * 10}">${document.averageRating}</span>
                </p>

                <div class="yui-cssbase body">
                    <div id="editable_cont" class="inline-editor-editable-container">
                        <span class="" id="hippogogreen:summary">${document.introduction}</span> <span
                            class=" inline" id="hippogogreen:description">
                        <@hst.html hippohtml=document.description/>
                    </span>
                    </div>
                </div>

            </div>
            <@hst.include ref="reviews"/>
        </div>
    </div>
</div>
</#if>

<@hst.headContribution category="componentsCss">
<!--  css for gallery widget -->
<link rel="stylesheet" type="text/css" media="screen" href="<@hst.link path="/js/galleryview-2.1.1/galleryview.css"/>"/>
</@hst.headContribution>

<!--  javascript for gallery widget -->
<@hst.headContribution category="componentsJavascript">
<script src="<@hst.link path="/js/jquery.mb.browser.min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="componentsJavascript">
<script src="<@hst.link path="/js/galleryview-2.1.1/jquery.easing.1.3.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="componentsJavascript">
<script src="<@hst.link path="/js/galleryview-2.1.1/jquery.galleryview-2.1.1-pack.js"/>"
        type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="componentsJavascript">
<script src="<@hst.link path="/js/galleryview-2.1.1/jquery.timers-1.2.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="componentsJavascript">
<script type="text/javascript">
    $(document).ready(function () {
        $('#gallery').galleryView({
            show_panels: true, //BOOLEAN - flag to show or hide panel portion of gallery
            show_filmstrip: true, //BOOLEAN - flag to show or hide filmstrip portion of gallery

            panel_width: 400, //INT - width of gallery panel (in pixels)
            panel_height: 300, //INT - height of gallery panel (in pixels)
            frame_width: 40, //INT - width of filmstrip frames (in pixels)
            frame_height: 30, //INT - width of filmstrip frames (in pixels)

            start_frame: 1, //INT - index of panel/frame to show first when gallery loads
            filmstrip_size: 3,
            transition_speed: 800, //INT - duration of panel/frame transition (in milliseconds)
            transition_interval: 4000, //INT - delay between panel/frame transitions (in milliseconds)

            overlay_opacity: 0.7, //FLOAT - transparency for panel overlay (1.0 = opaque, 0.0 = transparent)
            frame_opacity: 0.3, //FLOAT - transparency of non-active frames (1.0 = opaque, 0.0 = transparent)

            pointer_size: 4, //INT - Height of frame pointer (in pixels)

            nav_theme: 'light', //STRING - name of navigation theme to use (folder must exist within 'themes' directory)
            easing: 'swing', //STRING - easing method to use for animations (jQuery provides 'swing' or 'linear', more available with jQuery UI or Easing plugin)

            filmstrip_position: 'bottom', //STRING - position of filmstrip within gallery (bottom, top, left, right)
            overlay_position: 'bottom', //STRING - position of panel overlay (bottom, top, left, right)

            panel_scale: 'nocrop', //STRING - cropping option for panel images (crop = scale image and fit to aspect ratio determined by panel_width and panel_height, nocrop = scale image and preserve original aspect ratio)
            frame_scale: 'nocrop', //STRING - cropping option for filmstrip images (same as above)

            frame_gap: 5, //INT - spacing between frames within filmstrip (in pixels)

            show_captions: false, //BOOLEAN - flag to show or hide frame captions
            fade_panels: true, //BOOLEAN - flag to fade panels during transitions or swap instantly
            pause_on_hover: false
            //BOOLEAN - flag to pause slideshow when user hovers over the gallery

        });
    });
</script>
</@hst.headContribution>