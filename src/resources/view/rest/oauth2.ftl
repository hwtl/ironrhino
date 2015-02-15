<#if !base?has_content>
	<#assign base=statics['org.ironrhino.core.util.RequestUtils'].getBaseUrl(request)>
</#if>
<h4 style="text-align:center;">OAuth2</h4>
<ol>
<li>获取access_token
	<ul>
	<li>
	<h5><em>client_credential</em>方式,此方式获取的token代表的用户是client的所有者</h5>
	<ol>
	<li>client访问  <code>${base}/oauth/oauth2/token?grant_type=client_credential&client_id={client_id}&client_secret={client_secret}</code></li>
	<li>服务器返回 access_token, 示例: <code>{"expires_in":3600,"access_token":"{access_token}","refresh_token":"{refresh_token}"}</code></li>
	</ol>
	</li>
	<li>
	<h5><em>password</em>方式,此方式获取的token代表的用户是username对应的用户,<strong>client所有者需要管理员权限</strong></h5>
	<ol>
	<li>client访问  <code>${base}/oauth/oauth2/token?grant_type=password&client_id={client_id}&client_secret={client_secret}&username={username}&password={password}</code></li>
	<li>服务器返回 access_token, 示例: <code>{"expires_in":3600,"access_token":"{access_token}","refresh_token":"{refresh_token}"}</code></li>
	</ol>
	</li>
	<li>
	<h5><em>authorization_code</em>方式,此方式获取的token代表的用户是授权人</h5>
	<ol>
	<li>用户点击浏览器链接  <code>${base}/oauth/oauth2/auth?response_type=code&client_id={client_id}&redirect_uri={redirect_uri}</code>, redirect_uri需要和client时候预留的一致</li>
	<li>浏览器跳转到授权页面让用户输入用户名密码</li>
	<li>浏览器跳转到{redirect_uri},并且带上了请求参数code={code}</li>
	<li>client的后台根据返回的code访问 <code>${base}/oauth/oauth2/token?grant_type=authorization_code&code={code}&client_id={client_id}&client_secret={client_secret}&redirect_uri={redirect_uri}</code></li>
	<li>服务器返回 access_token, 示例: <code>{"expires_in":3600,"access_token":"{access_token}","refresh_token":"{refresh_token}"}</code></li>
	</ol>
	</li>
	</ul>
</li>
<li>把access_token放入请求参数或者请求头里面来调用API
	<div>
	请求参数名为access_token: <code>curl ${apiBaseUrl}/user/@self?access_token={access_token}</code>
	</div>
	<div>
	请求头名为Authorization: <code>curl -H "Authorization: Bearer {access_token}" ${apiBaseUrl}/user/@self</code>
	</div>
</li>
</ol>



其他token相关的API:
<ul>
<li>
刷新token: <code> ${base}/oauth/oauth2/token?grant_type=refresh_token&refresh_token={refresh_token}&client_id={client_id}&client_secret={client_secret}</code>
</li>
<li>
回收token: <code> ${base}/oauth/oauth2/revoke?access_token={access_token}</code>
</li>
</ul>