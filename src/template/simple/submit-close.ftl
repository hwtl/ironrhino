<#if !(parameters.type?has_content && parameters.type=="image")>${parameters.body}<#if (parameters.nameValue!'')?length gt 0>${parameters.nameValue}<#elseif (parameters.body!'')?length gt 0>${parameters.body}<#elseif parameters.label??><@s.property value="parameters.label"/></#if></button><#else>${parameters.body}</#if>