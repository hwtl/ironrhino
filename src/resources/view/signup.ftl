<!DOCTYPE html>
<#escape x as x?html><html>
<head>
<title>${action.getText('signup')}</title>
<meta name="body_class" content="welcome" />
<#assign notlogin = false>
<@authorize ifAllGranted="ROLE_BUILTIN_ANONYMOUS">
<#assign notlogin = true>
</@authorize>
<#if !notlogin>
<meta name="decorator" content="simple" />
<meta http-equiv="refresh" content="0; url=<@url value="/"/>" />
</#if>
</head>
<body>
<#if notlogin>
<div class="row">
	<div class="span6 offset3">
	<h2 class="caption">${action.getText('signup')}</h2>
	<div class="hero-unit">
	<@s.form method="post" action="${actionBaseUrl}" class="ajax focus form-horizontal well">
		<@s.textfield label="%{getText('email')}" name="email" type="email" class="span2 required checkavailable email" dynamicAttributes={"data-checkurl":"${getUrl('/signup/checkavailable')}"}/>
		<@s.textfield label="%{getText('username')}" name="username" class="span2 checkavailable regex" dynamicAttributes={"data-regex":"${statics['org.ironrhino.security.model.User'].USERNAME_REGEX_FOR_SIGNUP}","data-checkurl":"${getUrl('/signup/checkavailable')}"}/>
		<@s.password label="%{getText('password')}" name="password" class="required span2"/>
		<@s.password label="%{getText('confirmPassword')}" name="confirmPassword" class="required span2"/>
		<@s.submit value="%{getText('signup')}" class="btn-primary">
		<@s.param name="after"> <a class="btn hidden-pad hidden-tablet hidden-phone" href="${getUrl('/signup/forgot')}">${action.getText('signup.forgot')}</a> <a class="btn" href="${getUrl('/login')}">${action.getText('login')}</a></@s.param>
		</@s.submit>
	</@s.form>
	</div>
	</div>
</div>
<#else>
<div class="modal">
	<div class="modal-body">
		<div class="progress progress-striped active">
			<div class="bar" style="width: 50%;"></div>
		</div>
	</div>
</div>
</#if>
</body>
</html></#escape>