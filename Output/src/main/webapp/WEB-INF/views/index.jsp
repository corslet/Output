<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>问题井销项管理</title>
<jsp:include page="inc.jsp"></jsp:include>
<script type="text/javascript">
        var index_tabs;
        var index_tabsMenu;
//        var index_layout;
        $(function() {
//            index_layout = $('#index_layout').layout({
//                fit : true
//            });
            /*index_layout.layout('collapse', 'east');*/

            index_tabs = $('#index_tabs').tabs({
                fit : true,
                border : false,
                onContextMenu : function(e, title) {
                    e.preventDefault();
                    index_tabsMenu.menu('show', {
                        left : e.pageX,
                        top : e.pageY
                    }).data('tabTitle', title);
                },
                tools : [ {
                    iconCls : 'database_refresh',
                    handler : function() {
                        var href = index_tabs.tabs('getSelected').panel('options').href;
                        if (href) {/*说明tab是以href方式引入的目标页面*/
                            var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
                            index_tabs.tabs('getTab', index).panel('refresh');
                        } else {/*说明tab是以content方式引入的目标页面*/
                            var panel = index_tabs.tabs('getSelected').panel('panel');
                            var frame = panel.find('iframe');
                            try {
                                if (frame.length > 0) {
                                    for ( var i = 0; i < frame.length; i++) {
                                        frame[i].contentWindow.document.write('');
                                        frame[i].contentWindow.close();
                                        frame[i].src = frame[i].src;
                                    }
                                    if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
                                        try {
                                            CollectGarbage();
                                        } catch (e) {
                                        }
                                    }
                                }
                            } catch (e) {
                            }
                        }
                    }
                }, {
                    iconCls : 'delete',
                    handler : function() {
                        var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
                        var tab = index_tabs.tabs('getTab', index);
                        if (tab.panel('options').closable) {
                            index_tabs.tabs('close', index);
                        } else {
                            $.messager.alert('提示', '[' + tab.panel('options').title + ']不可以被关闭！', 'error');
                        }
                    }
                } ]
            });

            index_tabsMenu = $('#index_tabsMenu').menu({
                onClick : function(item) {
                    var curTabTitle = $(this).data('tabTitle');
                    var type = $(item.target).attr('title');

                    if (type === 'refresh') {
                        index_tabs.tabs('getTab', curTabTitle).panel('refresh');
                        return;
                    }

                    if (type === 'close') {
                        var t = index_tabs.tabs('getTab', curTabTitle);
                        if (t.panel('options').closable) {
                            index_tabs.tabs('close', curTabTitle);
                        }
                        return;
                    }

                    var allTabs = index_tabs.tabs('tabs');
                    var closeTabsTitle = [];

                    $.each(allTabs, function() {
                        var opt = $(this).panel('options');
                        if (opt.closable && opt.title != curTabTitle && type === 'closeOther') {
                            closeTabsTitle.push(opt.title);
                        } else if (opt.closable && type === 'closeAll') {
                            closeTabsTitle.push(opt.title);
                        }
                    });

                    for ( var i = 0; i < closeTabsTitle.length; i++) {
                        index_tabs.tabs('close', closeTabsTitle[i]);
                    }
                }
            });
        });
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north'" style="height:100px; background(url:'resources/title.png');" class="logo"></div>
<div data-options="region:'south'" style="height:20px;"></div>
<div data-options="region:'east',iconCls:'icon-reload',split:true" style="width:100px;"></div>
<div data-options="region:'west',title:'导航菜单',split:true,href:'${pageContext.request.contextPath}/WEB-INF/views/layout/west.jsp'" style="width:200px;"></div>
<div data-options="region:'center',title:'欢迎使用销项井查询系统'" >
    <div id="index_tabs" style="overflow: hidden;">
        <div title="首页" data-options="border:false" style="overflow: hidden;">
            <iframe src="${pageContext.request.contextPath}/WEB-INF/views/portal/index.jsp" frameborder="0" style="border: 0; width: 100%; height: 98%;"></iframe>
        </div>
    </div>
</div>

<div id="index_tabsMenu" style="width: 120px; display: none;">
    <div title="refresh" data-options="iconCls:'transmit'">刷新</div>
    <div class="menu-sep"></div>
    <div title="close" data-options="iconCls:'delete'">关闭</div>
    <div title="closeOther" data-options="iconCls:'delete'">关闭其他</div>
    <div title="closeAll" data-options="iconCls:'delete'">关闭所有</div>
</div>
</body>