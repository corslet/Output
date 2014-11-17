<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/addreason',
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
			<input name="id" class="span2" value="${id}" readonly="readonly" type="hidden"/>
			<table class="table table-hover table-condensed">
				<tr>
					<th>井号</th>
					<td><input name="wellnum" type="text" class="span2" value="${wellnum}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>异常原因</th>
					<td><input name="reason" type="text" placeholder="请输入原因" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<th>是否销项</th>
					<td><input name="signal" type="radio"/>销项</td>
				</tr>
				<tr>
					<th>转交部门</th>
					<td>
						<select class="easyui-combobox" name="state" style="width:200px;">
							<option value="工艺队">Alabama</option>
							<!-- 
							<option value="地质大队">Alaska</option>
							<option value="工技大队">Arizona</option>
							<option value="测试队">Arkansas</option>
							 -->
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>