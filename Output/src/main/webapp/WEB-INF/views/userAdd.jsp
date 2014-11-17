<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/add',
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
			<table class="table table-hover table-condensed">
				<tr>
					<th>用户名</th>
					<td><input name="username" type="text" placeholder="请输入用户名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
					<th>密码</th>
					<td><input name="password" type="text" placeholder="请输入密码地址" class="easyui-validatebox span2" data-options="required:true"></td>
				</tr>
				<tr>
					<th>矿别</th>
					<td>
						<select class="easyui-combobox" name="mine" style="width:200px;" class="easyui-validatebox span2" data-options="required:true">
							<option value="一矿">一矿</option>
							<option value="二矿">二矿</option>
							<option value="三矿">三矿</option>
							<option value="四矿">四矿</option>
							<option value="五矿">五矿</option>
							<option value="实验大队">实验大队</option>
						</select>
					</td>
					<th>队别</th>
					<td>
						<select class="easyui-combobox" name="org" style="width:200px;" class="easyui-validatebox span2" data-options="required:true">
							<option value="队别">队别</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>