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
<#-- @ftlvariable name="item" type="org.example.beans.Banner" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#-- @ftlvariable name="cparam" type="org.onehippo.cms7.essentials.components.info.EssentialsCarouselComponentInfo" -->

<#if pageable?? && pageable.items?has_content>
  <#if cparam.pause>
    <#assign pauseCarousel = 'hover'/>
  <#else>
    <#assign pauseCarousel = ''/>
  </#if>

  <div id="home-news">
    <div id="slider" class="carousel slide" data-ride="carousel" data-interval="${cparam.interval?c}"
         data-pause="${pauseCarousel}" data-wrap="${cparam.cycle?string}">
      <#if cparam.showNavigation>
        <ul class="carousel-indicators navigation" style="z-index: 1;">
          <#list pageable.items as item>
            <#if item_index==0>
              <#assign active = 'active'/>
            <#else>
              <#assign active = ''/>
            </#if>
            <li data-target="#slider" data-slide-to="${item_index}" class="${active}"><a href="#banner-${item_index}">${item.title}</a></li>
          </#list>
        </ul>
      </#if>
      <div class="scroll" style="overflow: hidden;">
        <div class="carousel-inner scrollContainer">
        <#list pageable.items as item>
          <#if item_index==0>
            <#assign active = ' active'/>
          <#else>
            <#assign active = ''/>
          </#if>
          <div class="item${active} panel">
            <img src="<@hst.link hippobean=item.image />" alt="${item.title}"/>
            <div class="carousel-caption title">
              <a href="<@hst.link hippobean=item.link />">${item.title}</a>
            </div>
          </div>
        </#list>
        </div>
      </div>
    </div>
  </div>

  <style type="text/css">
    /* Carousel base class */
    .carousel {
        height: ${cparam.carouselHeight}px;
        /*width: ${cparam.carouselWidth}px;*/
        margin-bottom: 60px;
    }

    /* Since positioning the image, we need to help out the caption */
    .carousel-caption {
        z-index: 10;
    }

    /* Declare heights because of positioning of img element */
    .carousel .item {
        height: ${cparam.carouselHeight}px;
        background-color: ${cparam.carouselBackgroundColor};
    }

    /* center images*/
    .carousel-inner > .item > img {
        margin: 0 auto;
    }
  </style>

  <@hst.headContribution category="componentsJavascript">
    <script type="text/javascript" src="<@hst.link path="/js/jquery-2.1.0.min.js"/>"></script>
  </@hst.headContribution>
  <@hst.headContribution category="componentsJavascript">
    <script type="text/javascript" src="<@hst.link path="/js/bootstrap.min.js"/>"></script>
  </@hst.headContribution>
<#elseif editMode>
  <img src="<@hst.link path='/images/essentials/catalog-component-icons/carousel.png'/>"> Click to edit Carousel
</#if>