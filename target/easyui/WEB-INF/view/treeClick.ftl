<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Hbase数据查询</title>
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/icon.css">
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
   <#-- <script type="text/javascript" src="js/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/god/queryHbase.js"></script>
    <link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />-->

</head>
<body class="easyui-layout">
<!--  页面上方区域     -->
<div region="north" split="true" style="height:60px;font-size: 26px;text-align: center;padding: 8px;background-color: #D1EEEE">数据查询</div>

<!--  页面左边区域    -->
<div region="west" style="width:180px" title="Hbase查询功能列表" split="true">
    <!-- 树形结构的功能列表 -->
    <ul id="tree"></ul>
</div>

<!--  页面中间内容（主面板）区域     -->
<div region="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页">欢迎来到Hbase价格库存查询页面</div>
    </div>
</div>

<div id="tabsMenu" class="easyui-menu" style="width:120px;">
    <div id="mm-tabreflash" data-options="name:6">
        刷新</div>
    <div id="mm-tabclose" data-options="name:1">关闭</div>
    <div id="mm-tabcloseall" data-options="name:2">全部关闭</div>
    <div id="mm-tabcloseother" data-options="name:3">除此之外全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-tabcloseright" data-options="name:4">当前页右侧全部关闭</div>
    <div id="mm-tabcloseleft" data-options="name:5">当前页左侧全部关闭</div>

</div>
<script>
    $(function () {

        //动态树形菜单数据
        var treeData = [{
            text : "Hbase查询功能列表",
            children : [{
                text : "具体数据查询",
                children : [{
                    text : "单一商品价格库存",
                    attributes : {
                        url : "/Freemarker/main"

                        /*
                                                url : '<iframe width="100%" height="100%" frameborder="0"  src="/Freemarker/main" style="width:100%;height:100%;margin:0px 0px;"></iframe>'
                        */
                    }
                }, {
                    text : "单一商品价格库存2",
                    attributes : {
                        url : ''

                    }
                }
                ]
            },{
                text : "数据量查询",
                children : [{
                    text : "总量统计",
                    attributes : {
                        url : '<iframe width="100%" height="100%" frameborder="0"  src="jsp/queryPriceStock.jsp" style="width:100%;height:100%;margin:0px 0px;"></iframe>'
                    }
                }, {
                    text : "总量统计2",
                    attributes : {
                        url : ''
                    }
                }
                ]
            }
            ]
        }
        ];

        //实例化树形菜单
        $("#tree").tree({
            data : treeData,
            lines : true,
            onClick : function (node) {
                if (node.attributes) {
                    Open(node.text, node.attributes.url);
                }
            }
        });
        //在右边center区域打开菜单，新增tab
        function Open(text, url) {
            if ($("#tabs").tabs('exists', text)) {
                $('#tabs').tabs('select', text);
            } else {
                var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
                $('#tabs').tabs('add', {
                    title : text,
                    closable : true,
                    content : content
                });
            }
        }

        //绑定tabs的右键菜单
        $("#tabs").tabs({
            onContextMenu : function (e, title,index) {
                e.preventDefault();
                if (index > 0) {
                    $('#tabsMenu').menu('show', {
                        left: e.pageX,
                        top: e.pageY
                    }).data("tabTitle", title);
                }
            }
        });

        //实例化menu的onClick事件
        $("#tabsMenu").menu({
            onClick : function (item) {
                closeTab(this, item.name);
            }
        });

        //几个关闭事件的实现
        function CloseTab(menu, type) {
            var curTabTitle = $(menu).data("tabTitle");
            var tabs = $("#tabs");

            if (type === "close") {
                tabs.tabs("close", curTabTitle);
                return;
            }

            var allTabs = tabs.tabs("tabs");
            var closeTabsTitle = [];

            $.each(allTabs, function () {
                var opt = $(this).panel("options");
                if (opt.closable && opt.title != curTabTitle && type === "Other") {
                    closeTabsTitle.push(opt.title);
                } else if (opt.closable && type === "All") {
                    closeTabsTitle.push(opt.title);
                }
            });

            for (var i = 0; i < closeTabsTitle.length; i++) {
                tabs.tabs("close", closeTabsTitle[i]);
            }
        }
    });


    //删除Tabs
    function closeTab(menu, type){
        var allTabs = $("#tabs").tabs('tabs');
        var allTabtitle = [];
        $.each(allTabs,function(i,n){
            var opt=$(n).panel('options');
            if(opt.closable)
                allTabtitle.push(opt.title);
        });
        var curTabTitle = $(menu).data("tabTitle");
        var curTabIndex = $("#tabs").tabs("getTabIndex", $("#tabs").tabs("getTab", curTabTitle));
        switch (type){
            case 1 :
            /*    var curTabTitle = $(menu).data("tabTitle");*/
                $("#tabs").tabs("close", curTabTitle);
                return false;
                break;
            case 2 :
                for(var i=0;i<allTabtitle.length;i++){
                    $('#tabs').tabs('close', allTabtitle[i]);
                }
                break;
            case 3 :
                for (var i = 0; i < allTabtitle.length; i++) {
                    if (curTabTitle != allTabtitle[i])
                        $('#tabs').tabs('close', allTabtitle[i]);
                }
                $('#tabs').tabs('select', curTabTitle);
                break;
            case 4 :
                for (var i = curTabIndex; i < allTabtitle.length; i++) {
                    $('#tabs').tabs('close', allTabtitle[i]);
                }
                $('#tabs').tabs('select', curTabTitle);
                break;
            case 5 :
                for (var i = 0; i < curTabIndex-1; i++) {
                    $('#tabs').tabs('close', allTabtitle[i]);
                }
                $('#tabs').tabs('select', curTabTitle);
                break;
            case 6: //刷新
                $("#tabs").tabs("getTab", curTabTitle).panel("refresh");
                break;
        }

    }

</script>
</body>
</html>