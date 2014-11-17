<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    var west_tree;
    var currentUserId = '${org}';
    	$(function(){
    		if(currentUserId == '地质大队' || currentUserId == '管理员')
    			{
	    			west_tree = $('#west_tree').tree({
		                data:[{
		                    text: '销项井信息查询',
		                    state: 'closed',
		                    children: [{
		                        text: '销项井查询',url:'./virification'
		                    },{
		                        text: '用户管理',url:'./fuck'
		                    }]
		                }],
		                onClick:function(node){
		                    if (node.url) {
		                        var url;
		                        if (node.url.indexOf('/') == 0) {/*如果url第一位字符是"/"，那么代表打开的是本地的资源*/
		                            url = '${pageContext.request.contextPath}' + node.url;
		                            if (url.indexOf('/druidController') == -1) {/*如果不是druid相关的控制器连接，那么进行遮罩层屏蔽*/
		                                parent.$.messager.progress({
		                                    title : '提示',
		                                    text : '数据处理中，请稍后....'
		                                });
		                            }
		                        } else {/*打开跨域资源*/
		                            url = node.url;
		                        }
		                        addTab({
		                            url : url,
		                            title : node.text,
		                            iconCls : node.iconCls
		                        });
		                    }
		                }
		            })
    			}
    		else
    			{
    			west_tree = $('#west_tree').tree({
	                data:[{
	                    text: '销项井信息查询',
	                    state: 'closed',
	                    children: [{
	                        text: '销项井查询',url:'./virification'
	                    }]
	                }],
	                onClick:function(node){
	                    if (node.url) {
	                        var url;
	                        if (node.url.indexOf('/') == 0) {/*如果url第一位字符是"/"，那么代表打开的是本地的资源*/
	                            url = '${pageContext.request.contextPath}' + node.url;
	                            if (url.indexOf('/druidController') == -1) {/*如果不是druid相关的控制器连接，那么进行遮罩层屏蔽*/
	                                parent.$.messager.progress({
	                                    title : '提示',
	                                    text : '数据处理中，请稍后....'
	                                });
	                            }
	                        } else {/*打开跨域资源*/
	                            url = node.url;
	                        }
	                        addTab({
	                            url : url,
	                            title : node.text,
	                            iconCls : node.iconCls
	                        });
	                    }
	                }
	            })
    			}
	            
        });
   	
   
    
    	
    

    function addTab(params) {
        var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:98%;"></iframe>';
        var t = $('#index_tabs');
        var opts = {
            title : params.title,
            closable : true,
            iconCls : params.iconCls,
            content : iframe,
            border : false,
            fit : true
        };
        if (t.tabs('exists', opts.title)) {
            t.tabs('select', opts.title);
            parent.$.messager.progress('close');
        } else {
            t.tabs('add', opts);
        }
    }
</script>
<div class="easyui-accordion" data-options="fit:true,border:false">
    <div title="管理功能"  data-options="border:false,iconCls:'anchor'">
        <div class="well well-small">
            <ul id="west_tree"></ul>
        </div>
    </div>
    <div title="其他功能" data-options="border:false,iconCls:'anchor'">

    </div>
</div>