<#--
This Work is in the public domain and is provided on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied,
including, without limitation, any warranties or conditions of TITLE,
NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE.
You are solely responsible for determining the appropriateness of using
this Work and assume any risks associated with your use of this Work.

This Work includes contributions authored by David E. Jones, not as a
"work for hire", who hereby disclaims any copyright to the same.
-->
<#recurse widgetsNode>

<#macro @element><p>=== Doing nothing for element ${.node?node_name}, not yet implemented. ===</p></#macro>

<#macro widgets>
<#if sri.doBoundaryComments()><!-- BEGIN screen[@location=${sri.getActiveScreenDef().location}].widgets --></#if>
<#recurse>
<#if sri.doBoundaryComments()><!-- END   screen[@location=${sri.getActiveScreenDef().location}].widgets --></#if>
</#macro>
<#macro "fail-widgets">
<#if sri.doBoundaryComments()><!-- BEGIN screen[@location=${sri.getActiveScreenDef().location}].fail-widgets --></#if>
<#recurse>
<#if sri.doBoundaryComments()><!-- END   screen[@location=${sri.getActiveScreenDef().location}].fail-widgets --></#if>
</#macro>

<#-- ================ Subscreens ================ -->
<#macro "subscreens-menu">
    <ul<#if .node["@id"]?has_content> id="${.node["@id"]}_menu"</#if> class="subscreens-menu">
    <#list sri.getActiveScreenDef().getSubscreensItemsSorted() as subscreensItem><#if subscreensItem.menuInclude>
        <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
        <li<#if urlInfo.inCurrentScreenPath> class="selected"</#if>><#if urlInfo.disableLink>${subscreensItem.menuTitle}<#else><a href="${urlInfo.minimalPathUrlWithParams}">${subscreensItem.menuTitle}</a></#if></li>
    </#if></#list>
    </ul>
    <div class="clear"></div>
</#macro>

<#macro "subscreens-active">
    <div<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if> class="subscreens-active">
    ${sri.renderSubscreen()}
    </div>
</#macro>

<#macro "subscreens-panel">
    <#if !(.node["@type"]?has_content) || .node["@type"] == "tab">
    <div<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if> class="subscreens-panel">
        <ul<#if .node["@id"]?has_content> id="${.node["@id"]}_menu"</#if> class="subscreens-menu">
        <#list sri.getActiveScreenDef().getSubscreensItemsSorted() as subscreensItem><#if subscreensItem.menuInclude>
            <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
            <li<#if urlInfo.inCurrentScreenPath> class="selected"</#if>><#if urlInfo.disableLink>${subscreensItem.menuTitle}<#else><a href="${urlInfo.minimalPathUrlWithParams}">${subscreensItem.menuTitle}</a></#if></li>
        </#if></#list>
        </ul>
        <div class="clear"></div>
        <div<#if .node["@id"]?has_content> id="${.node["@id"]}_active"</#if> class="subscreens-active">
        ${sri.renderSubscreen()}
        </div>
    </div>
    <#elseif .node["@type"] == "stack">
    <h1>TODO stack type subscreens-panel not yet supported.</h1>
    <#elseif .node["@type"] == "wizard">
    <h1>TODO wizard type subscreens-panel not yet supported.</h1>
    </#if>
</#macro>

<#-- ================ Section ================ -->
<#macro section>
    <#if sri.doBoundaryComments()><!-- BEGIN section[@name=${.node["@name"]}] --></#if>
    <div id="${.node["@name"]}">${sri.renderSection(.node["@name"])}
    </div>
    <#if sri.doBoundaryComments()><!-- END   section[@name=${.node["@name"]}] --></#if>
</#macro>
<#macro "section-iterate">
    <#if sri.doBoundaryComments()><!-- BEGIN section-iterate[@name=${.node["@name"]}] --></#if>
    <div id="${.node["@name"]}">${sri.renderSection(.node["@name"])}
    </div>
    <#if sri.doBoundaryComments()><!-- END   section-iterate[@name=${.node["@name"]}] --></#if>
</#macro>

<#-- ================ Containers ================ -->
<#macro container>    <div<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if><#if .node["@style"]?has_content> class="${.node["@style"]}"</#if>><#recurse>
    </div>
</#macro>

<#macro "container-panel">
    <div<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if>>
        <#if .node["panel-header"]?has_content>
        <div<#if .node["@id"]?has_content> id="${.node["@id"]}_header"</#if> class="panel-header"><#recurse .node["panel-header"][0]>
            <div class="clear"></div>
        </div></#if>
        <#if .node["panel-left"]?has_content>
        <#-- TODO <xs:attribute name="draggable" default="false" type="boolean"/> -->
        <div<#if .node["@id"]?has_content> id="${.node["@id"]}_left"</#if> class="panel-left"><#recurse .node["panel-left"][0]>
        </div></#if>
        <#if .node["panel-right"]?has_content>
        <div<#if .node["@id"]?has_content> id="${.node["@id"]}_right"</#if> class="panel-right"><#recurse .node["panel-right"][0]>
        </div></#if>
        <div<#if .node["@id"]?has_content> id="${.node["@id"]}_center"</#if> class="panel-center"><#recurse .node["panel-center"][0]>
        </div>
        <#if .node["panel-footer"]?has_content>
        <div class="clear"></div>
        <div<#if .node["@id"]?has_content> id="${.node["@id"]}_footer"</#if> class="panel-footer"><#recurse .node["panel-footer"][0]>
        </div></#if>
    </div>
</#macro>

<#-- ================ Includes ================ -->
<#macro "include-screen">
<#if sri.doBoundaryComments()><!-- BEGIN include-screen[@location=${.node["@location"]}][@share-scope=${.node["@share-scope"]?if_exists}] --></#if>
${sri.renderIncludeScreen(.node["@location"], .node["@share-scope"]?if_exists)}
<#if sri.doBoundaryComments()><!-- END   include-screen[@location=${.node["@location"]}][@share-scope=${.node["@share-scope"]?if_exists}] --></#if>
</#macro>

<#-- ============== Tree ============== -->
<#macro tree>
            <xs:sequence>
                <xs:element maxOccurs="unbounded" ref="tree-node"/>
            </xs:sequence>
            <xs:attribute type="xs:string" name="name" use="optional"/>
            <xs:attribute type="xs:string" name="root-node-name" use="required"/>
            <xs:attribute type="xs:string" name="open-depth" default="0"/>
            <xs:attribute type="xs:string" name="entity-name"/>
<!-- TODO implement -->
</#macro>

<#macro "tree-node">
            <xs:sequence>
                <xs:element minOccurs="0" ref="condition"/>
                <xs:choice minOccurs="0">
                    <xs:element ref="entity-find-one"/>
                    <xs:element ref="call-service"/>
                </xs:choice>
                <xs:element ref="widgets"/>
                <xs:element minOccurs="0" maxOccurs="unbounded" ref="tree-sub-node"/>
            </xs:sequence>
            <xs:attribute type="xs:string" name="name" use="required"/>
            <xs:attribute type="xs:string" name="entry-name" />
            <xs:attribute type="xs:string" name="entity-name" />
            <xs:attribute type="xs:string" name="join-field-name" />
<!-- TODO implement -->
</#macro>

<#macro "tree-sub-node">
            <xs:sequence>
                <xs:choice>
                    <xs:element ref="entity-find"/>
                    <xs:element ref="call-service"/>
                </xs:choice>
                <xs:element minOccurs="0" maxOccurs="unbounded" ref="out-field-map"/>
            </xs:sequence>
            <xs:attribute type="xs:string" name="node-name" use="required"/>

            out-field-map:
            <xs:attribute type="xs:string" name="field-name" use="required"/>
            <xs:attribute type="xs:string" name="to-field-name"/>
<!-- TODO implement -->
</#macro>

<#-- ============== Render Mode Elements =============== -->
<#macro "render-mode">
<#if .node["text"]?has_content>
    <#list .node["text"] as textNode>
        <#if textNode["@type"]?has_content && textNode["@type"] == sri.getRenderMode()><#assign textToUse = textNode/></#if>
    </#list>
    <#if !textToUse?has_content>
        <#list .node["text"] as textNode><#if !textNode["@type"]?has_content || textNode["@type"] == "any"><#assign textToUse = textNode/></#if></#list>
    </#if>
    <#if textToUse?exists>
        <#if textToUse["@location"]?has_content>
<#if sri.doBoundaryComments()><!-- BEGIN render-mode.text[@location=${textToUse["@location"]}][@template=${textToUse["@template"]?default("true")}] --></#if>
    <#-- NOTE: this still won't encode templates that are rendered to the writer -->
    <#if .node["@encode"]!"false" == "true">${sri.renderText(textToUse["@location"], textToUse["@template"]?if_exists)?html}<#else/>${sri.renderText(textToUse["@location"], textToUse["@template"]?if_exists)}</#if>
<#if sri.doBoundaryComments()><!-- END   render-mode.text[@location=${textToUse["@location"]}][@template=${textToUse["@template"]?default("true")}] --></#if>
        </#if>
        <#assign inlineTemplateSource = textToUse?string/>
        <#if inlineTemplateSource?has_content>
<#if sri.doBoundaryComments()><!-- BEGIN render-mode.text[inline][@template=${textToUse["@template"]?default("true")}] --></#if>
          <#if !textToUse["@template"]?has_content || textToUse["@template"] == "true">
            <#assign inlineTemplate = [inlineTemplateSource, sri.getActiveScreenDef().location + ".render_mode.text"]?interpret>
            <@inlineTemplate/>
          <#else/>
            <#if .node["@encode"]!"false" == "true">${inlineTemplateSource?html}<#else/>${inlineTemplateSource}</#if>
          </#if>
<#if sri.doBoundaryComments()><!-- END   render-mode.text[inline][@template=${textToUse["@template"]?default("true")}] --></#if>
        </#if>
    </#if>
</#if>
</#macro>

<#macro text><#-- do nothing, is used only through "render-mode" --></#macro>

<#-- ================== Standalone Fields ==================== -->
<#macro link>
<#assign urlInfo = sri.makeUrlByType(.node["@url"], .node["@url-type"]!"transition")/>
<#assign parameterMap = ec.getContext().get(.node["@parameter-map"]?if_exists)?if_exists/>
<#if urlInfo.disableLink>
<span<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if>>${ec.resource.evaluateStringExpand(.node["@text"], "")}</span>
<#else/>
<!-- TODO get parameters from the urlInfo, extend method there to accept parameter parent element, name of parameterMap in context -->
<#if (.node["@link-type"]?has_content && .node["@link-type"] == "anchor") ||
    ((!.node["@link-type"]?has_content || .node["@link-type"] == "auto") &&
     ((.node["@url-type"]?has_content && .node["@url-type"] != "transition") ||
      (!urlInfo.hasActions)))>
    <#assign parameterString><#t>
        <#t><#list .node["parameter"] as parameterNode>${parameterNode["@name"]?url}=${sri.makeValue(parameterNode["from-field"],parameterNode["value"])?url}<#if parameterNode_has_next>&amp;</#if></#list>
        <#t><#if .node["parameter"]?has_content && .node["@parameter-map"]?has_content && ec.getContext().get(.node["@parameter-map"])?has_content>&amp;</#if>
        <#t><#list parameterMap?keys as pKey>${pKey?url}=${parameterMap[pKey]?url}<#if pKey_has_next>&amp;</#if></#list>
    <#t></#assign>
    <a href="${urlInfo.url}<#if parameterString?has_content>?${parameterString}</#if>"<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if><#if .node["@target-window"]?has_content> target="${.node["@target-window"]}"</#if><#if .node["@confirmation"]?has_content> onclick="return confirm('${.node["@confirmation"]?js_string}')"</#if>>
    <#if .node["image"]?has_content><#visit .node["image"]/><#else/>${ec.resource.evaluateStringExpand(.node["@text"], "")}</#if>
    </a>
<#else/>
    <form method="post" action="${urlInfo.url}" name="${.node["@id"]!""}"<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if><#if .node["@target-window"]?has_content> target="${.node["@target-window"]}"</#if> onsubmit="javascript:submitFormDisableSubmit(this)">
        <#list .node["parameter"] as parameterNode><input name="${parameterNode["@name"]?html}" value="${sri.makeValue(parameterNode["@from-field"]?default(""),parameterNode["@value"]?default(""))?html}" type="hidden"/></#list>
        <#list parameterMap?if_exists?keys as pKey><input name="${pKey?html}" value="${parameterMap[pKey]?html}" type="hidden"/></#list>
    <#if .node["image"]?has_content><#assign imageNode = .node["image"][0]/>
    <input type="image" src="${sri.makeUrlByType(imageNode["@url"],imageNode["@url-type"]!"content")}"<#if imageNode["@alt"]?has_content> alt="${imageNode["@alt"]}"</#if><#if .node["@confirmation"]?has_content> onclick="return confirm('${.node["@confirmation"]?js_string}')"</#if>>
    <#else/>
    <input type="submit" value="${ec.resource.evaluateStringExpand(.node["@text"], "")}"<#if .node["@confirmation"]?has_content> onclick="return confirm('${.node["@confirmation"]?js_string}')"</#if>>
    </#if>
    </form>
    <#-- NOTE: consider using a link instead of submit buttons/image, would look something like this (would require id attribute, or add a name attribute):
        <a href="javascript:document.${.node["@id"]}.submit()">
            <#if .node["image"]?has_content>
            <img src="${sri.makeUrlByType(imageNode["@url"],imageNode["@url-type"]!"content")}"<#if imageNode["@alt"]?has_content> alt="${imageNode["@alt"]}"</#if>/>
            <#else/>
            ${ec.resource.evaluateStringExpand(.node["@text"], "")}
            <#/if>
        </a>
    -->
</#if>
</#if>
</#macro>
<#macro image><img src="${sri.makeUrlByType(.node["@url"],.node["@url-type"]!"content")}" alt="${.node["@alt"]!"image"}"<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if><#if .node["@width"]?has_content> width="${.node["@width"]}"</#if><#if .node["@height"]?has_content> height="${.node["@height"]}"</#if>/></#macro>
<#macro label>
    <#assign labelType = .node["@type"]?default("span")/>
    <#assign labelValue = ec.resource.evaluateStringExpand(.node["@text"], "")/>
    <#if (labelValue?length < 255)><#assign labelValue = ec.l10n.getLocalizedMessage(labelValue)/></#if>
    <${labelType}<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if>><#if .node["@encode"]!"true" == "false">${labelValue}<#else/>${labelValue?html?replace("\n", "<br>")}</#if></${labelType}>
</#macro>
<#macro parameter><#-- do nothing, used directly in other elements --></#macro>

<#-- ====================================================== -->
<#-- ======================= Form ========================= -->
<#macro "form-single">
<#if sri.doBoundaryComments()><!-- BEGIN form-single[@name=${.node["@name"]}] --></#if>
    <#-- Use the formNode assembled based on other settings instead of the straight one from the file: -->
    <#assign formNode = sri.getFtlFormNode(.node["@name"])/>
    <#assign urlInfo = sri.makeUrlByType(formNode["@transition"], "transition")/>
    <form name="${formNode["@name"]}" id="${formNode["@name"]}" method="post" action="${urlInfo.url}">
        <#if formNode["field-layout"]?has_content>
        <h3>TODO: implement form-single field-layout (form ${.node["@name"]})</h3>
        <#else/>
        <#-- TODO: change to something better than a table, perhaps HTML field label stuff -->
        <table class="form-single-outer">
            <#list formNode["field"] as fieldNode><@formSingleSubField fieldNode/></#list>
        </table>
        </#if>
    </form>
<#if sri.doBoundaryComments()><!-- END   form-single[@name=${.node["@name"]}] --></#if>
</#macro>
<#macro formSingleSubField fieldNode>
    <#list fieldNode["conditional-field"] as fieldSubNode>
        <#if ec.resource.evaluateCondition(fieldSubNode["@condition"], "")>
            <@formSingleWidget fieldSubNode/>
            <#return>
        </#if>
    </#list>
    <#if fieldNode["default-field"]?has_content>
        <@formSingleWidget fieldNode["default-field"][0]/>
        <#return>
    </#if>
</#macro>
<#macro formSingleWidget fieldSubNode>
    <#if fieldSubNode["ignored"]?has_content && (fieldSubNode?parent["@hide"]?if_exists != "false")><#return></#if>
    <#if fieldSubNode["hidden"]?has_content && (fieldSubNode?parent["@hide"]?if_exists != "false")><#recurse fieldSubNode/><#return></#if>
    <#if fieldSubNode?parent["@hide"]?if_exists == "true"><#return></#if>
    <tr>
        <td class="form-title"><#if fieldSubNode["submit"]?has_content>&nbsp;<#else/><@fieldTitle fieldSubNode/></#if></td>
        <td><#recurse fieldSubNode/></td>
    </tr>
</#macro>

<#macro "form-list">
<#if sri.doBoundaryComments()><!-- BEGIN form-list[@name=${.node["@name"]}] --></#if>
    <#-- Use the formNode assembled based on other settings instead of the straight one from the file: -->
    <#assign formNode = sri.getFtlFormNode(.node["@name"])/>
    <#assign urlInfo = sri.makeUrlByType(formNode["@transition"], "transition")/>
    <#assign listObject = ec.resource.evaluateContextField(formNode["@list"], "")/>
    <form name="${formNode["@name"]}" id="${formNode["@name"]}" method="post" action="${urlInfo.url}">
        <#if formNode["field-layout"]?has_content>
        <h3>TODO: implement form-list field-layout (form ${.node["@name"]})</h3>
        <#else/>
        <table class="form-list-outer">
            <tr class="form-header">
                <#list formNode["field"] as fieldNode><@formListHeaderField fieldNode/></#list>
            </tr>
            <#list listObject as listEntry>
                <#-- NOTE: the form-list.@list-entry attribute is handled in the ScreenForm class through this call: -->
                ${sri.startFormListRow(formNode["@name"], listEntry)}
                <tr class="form-row">
                    <#list formNode["field"] as fieldNode><@formListSubField fieldNode/></#list>
                </tr>
                ${sri.endFormListRow()}
            </#list>
            ${sri.safeCloseList(listObject)}<#-- if listObject is an EntityListIterator, close it -->
        </table>
        </#if>
    </form>
<#if sri.doBoundaryComments()><!-- END   form-list[@name=${.node["@name"]}] --></#if>
</#macro>
<#macro formListHeaderField fieldNode>
    <#if fieldNode["@hide"]?if_exists == "true"><#return></#if>
    <#if (!fieldNode["@hide"]?has_content) && fieldNode?children?size == 1 && (fieldNode?children[0]["hidden"]?has_content || fieldNode?children[0]["ignored"]?has_content)><#return></#if>
    <#if fieldNode["header-field"]?has_content>
        <#assign fieldSubNode = fieldNode["header-field"][0]/>
    <#elseif fieldNode["default-field"]?has_content/>
        <#assign fieldSubNode = fieldNode["default-field"][0]/>
    <#else/>
        <#-- this only makes sense for fields with a single conditional -->
        <#assign fieldSubNode = fieldNode["conditional-field"][0]/>
    </#if>
    <td class="form-title"><#if fieldSubNode["submit"]?has_content>&nbsp;<#else/><@fieldTitle fieldSubNode/></#if></td>
</#macro>
<#macro formListSubField fieldNode>
    <#list fieldNode["conditional-field"] as fieldSubNode>
        <#if ec.resource.evaluateCondition(fieldSubNode["@condition"], "")>
            <@formListWidget fieldSubNode/>
            <#return>
        </#if>
    </#list>
    <#if fieldNode["default-field"]?has_content>
        <@formListWidget fieldNode["default-field"][0]/>
        <#return>
    </#if>
</#macro>
<#macro formListWidget fieldSubNode>
    <#if fieldSubNode["ignored"]?has_content><#return/></#if>
    <#if fieldSubNode["hidden"]?has_content><#recurse fieldSubNode/><#return/></#if>
    <#if fieldSubNode?parent["@hide"]?if_exists == "true"><#return></#if>
    <td><#recurse fieldSubNode/></td>
</#macro>


<#macro fieldName widgetNode><#assign fieldNode=widgetNode?parent?parent/>${fieldNode["@name"]?html}</#macro>
<#-- TODO: use fieldId everywhere! -->
<#macro fieldId widgetNode><#assign fieldNode=widgetNode?parent?parent/>${fieldNode?parent["@name"]}_${fieldNode["@name"]}<#if listEntry_index?has_content>_${listEntry_index}</#if></#macro>
<#macro fieldTitle fieldSubNode><#assign titleValue><#if fieldSubNode["@title"]?has_content>${fieldSubNode["@title"]}<#else/><#list fieldSubNode?parent["@name"]?split("(?=[A-Z])", "r") as nameWord>${nameWord?cap_first?replace("Id", "ID")} </#list></#if></#assign>${ec.l10n.getLocalizedMessage(titleValue)}</#macro>

<#macro "field"><#-- shouldn't be called directly, but just in case --><#recurse/></#macro>
<#macro "conditional-field"><#-- shouldn't be called directly, but just in case --><#recurse/></#macro>
<#macro "default-field"><#-- shouldn't be called directly, but just in case --><#recurse/></#macro>

<#-- ================== Form Field Widgets ==================== -->

<#macro "date-time">
    <#if .node["@type"]?if_exists == "time"><#assign size=9/><#assign maxlength=12/>
    <#elseif .node["@type"]?if_exists == "date"><#assign size=10/><#assign maxlength=10/>
    <#else><#assign size=23/><#assign maxlength=23/>
    </#if>
    <#assign id><@fieldId .node/></#assign>
    <input type="text" name="<@fieldName .node/>" value="${sri.getFieldValue(.node?parent?parent, .node["@default-value"]!"")?html}" size="${size}" maxlength="${maxlength}" id="${id}">
<#if .node["@type"]?if_exists != "time">
    <script type="text/javascript">
        <#if shortDateInput?exists && shortDateInput>
            jQuery("#${id}").datepicker({
        <#else>
            jQuery("#${id}").datetimepicker({showSecond: true, timeFormat: 'hh:mm:ss', stepHour: 1, stepMinute: 5, stepSecond: 10,
        </#if>
                showOn: 'button', buttonImage: '', buttonText: '', buttonImageOnly: false, dateFormat: 'yyyy-mm-dd'});
    </script>
</#if>
</#macro>

<#macro "display">
    <#assign fieldValue = ""/>
    <#if .node["@text"]?has_content>
        <#assign fieldValue = ec.resource.evaluateStringExpand(.node["@text"], "")/>
    <#else/>
        <#assign fieldValue = sri.getFieldValue(.node?parent?parent, "")/>
    </#if>
    <#if .node["@currency-unit-field"]?has_content><#assign fieldValue = formatCurrency(fieldValue, .node["@currency-unit-field"], 2)/></#if>
    <span id="<@fieldId .node/>"><#if .node["@encode"]!"true" == "false">${fieldValue!"&nbsp;"}<#else/>${(fieldValue!" ")?html?replace("\n", "<br>")}</#if></span>
    <#if !.node["@also-hidden"]?exists || .node["@also-hidden"] == "true"><input type="hidden" name="<@fieldName .node/>" value="${(fieldValue!"")?html}"></#if>
</#macro>
<#macro "display-entity">
    <#assign fieldValue = ""/><#assign fieldValue = sri.getFieldEntityValue(.node)/>
    <span id="<@fieldId .node/>"><#if .node["@encode"]!"true" == "false">${fieldValue!"&nbsp;"}<#else/>${(fieldValue!" ")?html?replace("\n", "<br>")}</#if></span>
    <#if .node["@also-hidden"]!"true" == "true"><input type="hidden" name="<@fieldName .node/>" value="${(fieldValue!"")?html}"></#if>
</#macro>

<#macro "drop-down">
    <#assign options = []/><#assign options = sri.getFieldOptions(.node)/>
    <#assign currentValue = sri.getFieldValue(.node?parent?parent, "")/>
    <#if !currentValue?has_content><#assign currentValue = .node["@no-current-selected-key"]?if_exists/></#if>
    <#assign currentDescription = (options.get(currentValue))?if_exists/>
    <#if !currentDescription?has_content && .node["@current-description"]?has_content>
        <#assign currentDescription = ec.resource.evaluateStringExpand(.node["@current-description"], "")/>
    </#if>
    <#assign id><@fieldId .node/></#assign>

    <select name="<@fieldName .node/>" id="${id}"<#if .node["@allow-multiple"]?if_exists == "true"> multiple="multiple"</#if><#if .node["@size"]?has_content> size="${.node["@size"]}"</#if>>
    <#if currentValue?has_content && (.node["@current"]?if_exists != "selected") && !(.node["@allow-multiple"]?if_exists == "true")>
        <option selected="selected" value="${currentValue}">${currentDescription!currentValue}</option><#rt/>
        <option value="${currentValue}">---</option><#rt/>
    </#if>
    <#if !(.node["@allow-empty"]?if_exists == "true") || !options?has_content>
        <option value="">&nbsp;</option>
    </#if>
    <#list (options.keySet())?if_exists as key>
        <option<#if currentValue?has_content && currentValue == key> selected="selected"</#if> value="${key}">${options.get(key)}</option>
    </#list>
    </select>
    <#if .node["auto-complete"]?has_content>
    <#-- TODO: auto-complete attributes, get it working -->
    <script language="JavaScript" type="text/javascript">
        jQuery(function() { jQuery("#${id}").combobox(); });
    </script>
    </#if>
</#macro>
<#macro check>
    <#assign options = []/><#assign options = sri.getFieldOptions(.node)/>
    <#assign currentValue = sri.getFieldValue(.node?parent?parent, "")/>
    <#if !currentValue?has_content><#assign currentValue = .node["@no-current-selected-key"]?if_exists/></#if>
    <#assign id><@fieldId .node/></#assign>
    <#assign curName><@fieldName .node/></#assign>
    <#list (options.keySet())?if_exists as key>
        <span id="${id}<#if (key_index > 0)>_${key_index}</#if>"><input type="checkbox" name="${curName}" value="${key?html}"<#if .node["@all-checked"]?if_exists == "true"> checked="checked"<#elseif currentValue?has_content && currentValue==key> checked="checked"</#if>>${options.get(key)?default("")}</span>
    </#list>
</#macro>
<#macro "radio">
    <#assign options = []/><#assign options = sri.getFieldOptions(.node)/>
    <#assign currentValue = sri.getFieldValue(.node?parent?parent, "")/>
    <#if !currentValue?has_content><#assign currentValue = .node["@no-current-selected-key"]?if_exists/></#if>
    <#assign id><@fieldId .node/></#assign>
    <#assign curName><@fieldName .node/></#assign>
    <#list (options.keySet())?if_exists as key>
        <span id="${id}<#if (key_index > 0)>_${key_index}</#if>"><input type="radio" name="${curName}" value="${key?html}"<#if currentValue?has_content && currentValue==key> checked="checked"</#if>>${options.get(key)?default("")}</span>
    </#list>
</#macro>

<#macro "hidden">
    <input type="hidden" name="<@fieldName .node/>" value="${sri.getFieldValue(.node?parent?parent, .node["@default-value"]!"")}">
</#macro>
<#macro "ignored"><#-- shouldn't ever be called as it is checked in the form-* macros --></#macro>

<#macro "lookup">
    <#-- TODO: <xs:element minOccurs="0" ref="auto-complete"/> -->
    <#assign curFieldName = .node?parent?parent["@name"]?html/>
    <#assign curFormName = .node?parent?parent?parent["@name"]?html/>
    <input type="text" name="${curFieldName}" value="${sri.getFieldValue(.node?parent?parent, .node["@default-value"]!"")?html}" size="${.node.@size!"30"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if><#if ec.resource.evaluateCondition(.node.@disabled!"false", "")> disabled="disabled"</#if> id="<@fieldId .node/>">
    <#assign ajaxUrl = ""/><#-- TODO once the JSON service stuff is in place put something real here -->
    <script type="text/javascript">
        jQuery(document).ready(function() {
            new ConstructLookup("${.node["@target-screen"]}", "${id}", document.${curFormName}.${curFieldName},
            <#if .node["@secondary-field"]?has_content>document.${curFormName}.${.node["@secondary-field"]}<#else>null</#if>,
            "${curFormName}", "${width!""}", "${height!""}", "${position!"topcenter"}", "${fadeBackground!"true"}", "${ajaxUrl!""}", "${showDescription!""}", ''); });
    </script>
</#macro>

<#macro "password"><input type="password" name="<@fieldName .node/>" size="${.node.@size!"25"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if> id="<@fieldId .node/>"></#macro>

<#macro "reset"><input type="reset" name="<@fieldName .node/>" value="<@fieldTitle .node?parent/>" id="<@fieldId .node/>"></#macro>

<#macro "submit">
<#if .node["image"]?has_content><#assign imageNode = .node["image"][0]/>
    <input type="image" src="${sri.makeUrlByType(imageNode["@url"],imageNode["@url-type"]!"content")}" alt="<#if imageNode["@alt"]?has_content>${imageNode["@alt"]}<#else/><@fieldTitle .node?parent/></#if>"<#if imageNode["@width"]?has_content> width="${imageNode["@width"]}"</#if><#if imageNode["@height"]?has_content> height="${imageNode["@height"]}"</#if>
<#else><input type="submit"</#if> name="<@fieldName .node/>" value="<@fieldTitle .node?parent/>"<#if .node["@confirmation"]?has_content> onclick="return confirm('${.node["@confirmation"]?js_string}');"</#if> id="<@fieldId .node/>">
</#macro>

<#macro "text-area"><textarea name="<@fieldName .node/>" cols="${.node["@cols"]!"60"}" rows="${.node["@rows"]!"3"}"<#if .node["@read-only"]!"false" == "true"> readonly="readonly"</#if><#if .node["@maxlength"]?has_content> maxlength="${maxlength}"</#if> id="<@fieldId .node/>">${sri.getFieldValue(.node?parent?parent, .node["@default-value"]!"")?html}</textarea></#macro>

<#macro "text-line"><input type="text" name="<@fieldName .node/>" value="${sri.getFieldValue(.node?parent?parent, .node["@default-value"]!"")?html}" size="${.node.@size!"30"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if><#if ec.resource.evaluateCondition(.node.@disabled!"false", "")> disabled="disabled"</#if> id="<@fieldId .node/>"></#macro>

<#-- ===============================================================================================

<#macro "date-find">
            <xs:attribute name="type" default="timestamp">
                <xs:simpleType>
                    <xs:restriction base="xs:token">
                        <xs:enumeration value="timestamp"/>
                        <xs:enumeration value="date-time"/>
                        <xs:enumeration value="date"/>
                        <xs:enumeration value="time"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:attribute>
            <xs:attribute name="default-value" type="xs:string"/>
            <xs:attribute name="default-option-from" default="equals">
                <xs:simpleType>
                    <xs:restriction base="xs:string">
                        <xs:enumeration value="equals"/>
                        <xs:enumeration value="same-day"/>
                        <xs:enumeration value="greater-day-start"/>
                        <xs:enumeration value="greater"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:attribute>
            <xs:attribute name="default-option-thru" default="less">
                <xs:simpleType>
                    <xs:restriction base="xs:string">
                        <xs:enumeration value="less"/>
                        <xs:enumeration value="up-to-day-start"/>
                        <xs:enumeration value="up-to-day-end"/>
                        <xs:enumeration value="empty"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:attribute>
</#macro>

<#macro "file">
            <xs:attribute name="size" type="xs:positiveInteger" default="25"/>
            <xs:attribute name="maxlength" type="xs:positiveInteger"/>
            <xs:attribute name="default-value" type="xs:string"/>
</#macro>
<#macro "range-find">
            <xs:attribute name="size" type="xs:positiveInteger" default="25"/>
            <xs:attribute name="maxlength" type="xs:positiveInteger"/>
            <xs:attribute name="default-value" type="xs:string"/>
            <xs:attribute name="default-option-from" default="greater-equals">
                <xs:simpleType>
                    <xs:restriction base="xs:string">
                        <xs:enumeration value="equals"/>
                        <xs:enumeration value="greater"/>
                        <xs:enumeration value="greater-equals"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:attribute>
            <xs:attribute name="default-option-thru" default="less-equals">
                <xs:simpleType>
                    <xs:restriction base="xs:string">
                        <xs:enumeration value="less"/>
                        <xs:enumeration value="less-equals"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:attribute>
</#macro>
<#macro "text-find">
            <xs:attribute name="size" type="xs:positiveInteger" default="25"/>
            <xs:attribute name="maxlength" type="xs:positiveInteger"/>
            <xs:attribute name="default-value" type="xs:string"/>
            <xs:attribute name="ignore-case" default="true" type="boolean"/>
            <xs:attribute name="default-option">
                <xs:simpleType>
                    <xs:restriction base="xs:string">
                        <xs:enumeration value="equals"/>
                        <xs:enumeration value="not-equals"/>
                        <xs:enumeration value="like"/>
                        <xs:enumeration value="contains"/>
                        <xs:enumeration value="empty"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:attribute>
            <xs:attribute name="hide-options" default="false">
                <xs:simpleType>
                    <xs:restriction base="xs:token">
                        <xs:enumeration value="true"/>
                        <xs:enumeration value="false"/>
                        <xs:enumeration value="ignore-case"/>
                        <xs:enumeration value="options"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:attribute>
</#macro>
-->