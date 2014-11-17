<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<jsp:include page="inc.jsp"></jsp:include>
<script type="text/javascript">
		$.canEdit = true;
</script>

<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/getteambypage',
			fit : true,
			fitColumns : true,
			border : false,
			pagination : true,
			idField : 'id',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'name',
			sortOrder : 'desc',
			checkOnSelect : false,
			selectOnCheck : false,
			nowrap : false,
			columns : [[{
				field : 'id',
				title : '编号',
				width : 150
			},{
				field : 'wellnum',
				title : '井号',
				width : 80
			},{
				field : 'date',
				title : '提取时间',
				width : 150,
				sortable : true,
				formatter : function(value, row, index) {
					var date = new Date(value);
                    var year = date.getFullYear().toString();
                    var month = (date.getMonth() + 1);
                    var day = date.getDate().toString();
                    var hour = date.getHours().toString();
                    var minutes = date.getMinutes().toString();
                    var seconds = date.getSeconds().toString();
                    if (month < 10) {
                        month = "0" + month;
                    }
                    if (day < 10) {
                        day = "0" + day;
                    }
                    if (hour < 10) {
                        hour = "0" + hour;
                    }
                    if (minutes < 10) {
                        minutes = "0" + minutes;
                    }
                    if (seconds < 10) {
                        seconds = "0" + seconds;
                    }
                    return year + "/" + month + "/" + day + " " + hour + ":" + minutes + ":" + seconds;
				}
			},{
				field : 'mine',
				title : '矿别',
				width : 50
			},{
				field : 'org',
				title : '队别',
				width : 50
			},{
				field : 'bz',
				title : '备注',
				width : 250
			}, 
			{
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					if ($.canEdit) {
						str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/>', row.id, 'resources/style/images/extjs_icons/pencil.png');
					}
					str += '&nbsp;';
					if ($.canGrant) {
						str += $.formatString('<img onclick="grantFun(\'{0}\');" src="{1}" title="授权"/>', row.id, 'resources/style/images/extjs_icons/key.png');
					}
					str += '&nbsp;';
					if ($.canDelete) {
						str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/>', row.id, '${pageContext.request.contextPath}/resources/style/images/extjs_icons/cancel.png');
					}
					str += '&nbsp;';
					if ($.canEditPwd) {
						str += $.formatString('<img onclick="editPwdFun(\'{0}\');" src="{1}" title="修改密码"/>', row.id, '${pageContext.request.contextPath}/resources/style/images/extjs_icons/lock/lock_edit.png');
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#searchForm table').show();
				parent.$.messager.progress('close');
				$(this).datagrid('tooltip');
			},
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll').datagrid('uncheckAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	});

	function editFun(id) {
		var rows = dataGrid.datagrid('getSelections');
		id = rows[0].id;
		wellnum = rows[0].wellnum;
		/*
		if (id == 'undefined') {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
			wellnum = rows[0].wellnum;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}*/
		parent.$.modalDialog({
			title : '填写原因信息',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/editPage?id=' + id+'&wellnum='+wellnum,
			buttons : [{
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			}]
		});
	}

	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
</script>
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
	</div>
</body>
</html>