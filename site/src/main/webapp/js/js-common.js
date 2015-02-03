/*
 * Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Default values for text size script
var textSizes = [13, 15, 17];

$(document).ready(function() {


  $(".parameters li a").toggle(
    function () {
      $(this).parent().children("div").show("slow");
    },
    function () {
      $(this).parent().children("div").hide("slow");
    });

  var inputField = $(".search-field, .login-field");
  var inputText = new Array(inputField.length);
  
  for(i=0; i<inputField.length; i++) {
    inputText[i] = $(inputField[i]).val();
    eval('$(inputField[i]).focus(function(){ if($(this).val() == "' + inputText[i] + '") { $(this).val(""); } $(this).removeClass("gray"); });');
    eval('$(inputField[i]).blur(function(){ if($(this).val() == "") { $(this).val("' + inputText[i] + '"); } $(this).addClass("gray"); });');
  }

});

oldTextAry = new Array();

function changeText (fieldObj, newTexStr) {
  if (newTexStr == fieldObj.innerHTML) {
    fieldObj.innerHTML = oldTextAry[fieldObj.id];
  } 
  else {
    oldTextAry[fieldObj.id] = fieldObj.innerHTML;
    fieldObj.innerHTML = newTexStr;
  }
}



/**
 * Sanatizes the value of a form field that will be submitted as a request parameter. The field is emptied when it
 * contains the given default text. All '<' and '>' characters are removed from the field so the XSSUrlFilter is not
 * triggered.
 *
 * @param field reference to the field whose value must be sanitized
 * @param defaultText the default text used for the field (optional)
 */
function sanitizeRequestParam(field, defaultText) {
    var query = field.value;
    if (query === defaultText) {
        query = '';
    } else {
        // remove the less-than and greater-than characters that will cause the XSSUrlFilter to return a 400 page
        query = query.replace(/</g, '');
        query = query.replace(/>/g, '');
    }
    field.value = query;
}
