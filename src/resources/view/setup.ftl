<!DOCTYPE html>
<#escape x as x?html><html>
<head>
<title>${action.getText('setup')}</title>
<meta name="body_class" content="welcome" />
</head>
<body>
<div class="row">
	<div class="span6 offset3">
	<h2 class="caption">${action.getText('setup')}</h2>
	<div class="hero-unit">
	<@s.form method="post" action="${actionBaseUrl}" class="ajax focus form-horizontal well">
		<#list setupParameters as p>
		<#if p.type=='boolean'>
		<@s.checkbox label="%{getText('${p.label?has_content?string(p.label,p.name)}')}" name=p.name class="${p.required?string('required ','')}custom"/>
		<#elseif p.type=='integer'>
		<@s.textfield label="%{getText('${p.label?has_content?string(p.label,p.name)}')}" type="number" name=p.name value=p.defaultValue! placeholder=action.getText(p.placeholder!) class="${p.required?string('required ','')}integer span2" />
		<#elseif p.type=='double'>
		<@s.textfield label="%{getText('${p.label?has_content?string(p.label,p.name)}')}" type="number" name=p.name value=p.defaultValue! placeholder=action.getText(p.placeholder!) class="${p.required?string('required ','')}double span2" />
		<#else>
		<@s.textfield label="%{getText('${p.label?has_content?string(p.label,p.name)}')}" name=p.name value=p.defaultValue! placeholder=action.getText(p.placeholder!) class="${p.required?string('required ','')}span2" />
		</#if>
		</#list>
		<@s.submit value="%{getText('confirm')}" class="btn-primary"/>
	</@s.form>
	</div>
	</div>
</div>
</body>
</html></#escape>