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

<#--
<@hst.setBundle basename="essentials.global"/>
<hr></hr>
<div class="text-center">
  <sub><@fmt.message key="footer.text"/></sub>
</div>
<@hst.include ref="container"/>
-->

              <div id="ft">
                <div class="logo">
                  <a href="http://www.onehippo.com"> <img src="<@hst.link path="images/logo-hippo.png"/>" alt="onehippo.com" />
                  </a>

                  <p>Hippo &copy; 2010-2014</p>

                  <p>
                    <a href="about/terms--conditions.html">Terms &amp; Conditions</a>
                  </p>
                </div>
                <div class="yui-gb" id="ft-nav">
                  <div class="yui-u first">
                    <h3>SERVICE</h3>
                    <ul>
                      <li><a href="contactus.html">Contact</a></li>
                      <li><a href="rss">RSS</a></li>
                    </ul>
                  </div>
                  <div class="yui-u">
                    <h3>SECTIONS</h3>
                    <ul>
                      <li><a href="news.html">News &amp; Events</a></li>
                      <li><a href="products.html">Products</a></li>
                      <li><a href="about.html">About</a></li>
                    </ul>
                  </div>
                </div>
                <img id="ft-image" src="<@hst.link path="images/ft-leaf.png"/>" alt="" />
              </div>
