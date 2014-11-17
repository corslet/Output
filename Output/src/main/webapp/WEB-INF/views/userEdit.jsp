<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/edit',
			onSubmit : function() {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				var isValid = $(this).form('validate');
				if (!isValid) {
					parent.$.messager.progress('close');
				}
				return isValid;
			},
			success : function(result) {
				parent.$.messager.progress('close');
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="form" method="post">
			<input name="id" type="hidden" class="span2" value="${id}" readonly="readonly">
			<table class="table table-hover table-condensed">
				<tr>
					<th>用户名</th>
					<td><input name="username" type="text" value="${username}" class="easyui-validatebox span2" data-options="required:true" value=""></td>
					<th>密码</th>
					<td><input name="password" type="text" value="${password}" class="easyui-validatebox span2" data-options="required:true"></td>
				</tr>
				<tr>
					<th>矿别</th>
					<td><input name="mine" type="text" value="${mine}" class="easyui-validatebox span2" data-options="required:true"></td>
					<th>队别</th>
					<td><input name="org" type="text" value="${org}" class="easyui-validatebox span2" data-options="required:true"></td>
				</tr>
			</table>
		</form>
	</div>
</div>