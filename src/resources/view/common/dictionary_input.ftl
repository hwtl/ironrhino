<#assign view=Parameters.view!/>
<!DOCTYPE html>
<#escape x as x?html><html>
<head>
<title><#if dictionary.new>${action.getText('create')}<#else>${action.getText('edit')}</#if>${action.getText('dictionary')}</title>
</head>
<body>
<@s.form action="${actionBaseUrl}/save" method="post" class="ajax${view?has_content?string('',' importable')}" style="text-align:center;">
	<#if !dictionary.new>
		<@s.hidden name="dictionary.id" />
	</#if>
	<@s.hidden name="dictionary.version" class="version"/>
	<#if view=='embedded'>
		<@s.hidden name="dictionary.name"/>
		<@s.hidden name="dictionary.description" />
	<#else>
	<div class="row-fluid">
		<div class="span5"><span>${action.getText('name')}: </span><#if view=='brief'><@s.hidden name="dictionary.name"/>${dictionary.name!}<#else><@s.textfield theme="simple" name="dictionary.name" class="required checkavailable"/></#if></div>
		<div class="span5"><span>${action.getText('description')}: </span><#if view=='brief'><@s.hidden name="dictionary.description"/>${dictionary.description!}<#else><@s.textfield theme="simple" name="dictionary.description" /></#if></div>
	</div>
	</#if>
	<table class="datagrid nullable table table-condensed">
	<@s.hidden name="__datagrid_dictionary.items" />
		<style scoped>
		tr.option{
			background-color:#F5F5F5;
		}
		tr.group{
			background-color:#E5E5E5;
		}
		</style>
		<thead>
			<tr>
				<th style="width:33%;">${action.getText('value')}</th>
				<th>${action.getText('label')}</th>
				<#if !(view=='embedded'||view=='brief')>
				<th style="width:15%;">${action.getText('type')}</th>
				</#if>
				<th class="manipulate"></th>
			</tr>
		</thead>
		<tbody>
			<#assign size = 0>
			<#if dictionary.items?? && dictionary.items?size gt 0>
				<#assign size = dictionary.items?size-1>
			</#if>
			<#list 0..size as index>
			<tr class="linkage">
				<td><@s.textfield theme="simple" name="dictionary.items[${index}].value" style="width:90%;" class="required${(!((view=='embedded'||view=='brief')))?string(' showonadd linkage_component option',' ')}"/></td>
				<td><@s.textfield theme="simple" name="dictionary.items[${index}].label" style="width:90%;"/></td>
				<#if !(view=='embedded'||view=='brief')>
				<td><select class="linkage_switch" style="width:100px;">
						<option value="option">${action.getText('option')}</option>
						<option value="group"<#if dictionary.items[index]?? && dictionary.items[index].value?? && !dictionary.items[index].value?has_content>selected="selected"</#if>>${action.getText('group')}</option>
					</select></td>
				</#if>
				<td class="manipulate"></td>
			</tr>
			</#list>
		</tbody>
	</table>
	<@s.submit value="%{getText('save')}" class="btn-primary"/>
</@s.form>
</body>
</html></#escape>


