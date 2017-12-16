<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>type</title>
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/icon.css">
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>

<#--    <script type="text/javascript" src="/static/jquery-easyui-1.5/easyloader.js'"></script>-->
</head>
<body>

<div id="headPanl"    style="width:100%;height:33px;margin-top: 0px;position:relative;overflow:hidden;">
    <div style="padding:5px;position:absolute; bottom: 0; left: 0;">
        <a href="#" class="easyui-menubutton" menu="#mm1" iconCls="icon-edit" style="background:#fafafa;">Edit</a>
        <a href="#" class="easyui-menubutton" menu="#mm2" iconCls="icon-help" style="background:#fafafa;">Help</a>
    </div>
    <div id="mm1" style="width:100px;">
        <div iconCls="icon-undo">Undo</div>
        <div iconCls="icon-redo">Redo</div>
        <div class="menu-sep"></div>
        <div>Cut</div>
        <div>Copy</div>
        <div>Paste</div>
        <div class="menu-sep"></div>
        <div iconCls="icon-remove">Delete</div>
        <div>Select All</div>
    </div>
    <div id="mm2" style="width:100px;">
        <div>Help</div>
        <div>Update</div>
        <div>About</div>
    </div>
</div>
<div class="easyui-layout" style="width:100%;height:100%;">
    <div region="west" split="true" title="Navigator" style="width:150px;">
        <div class="easyui-accordion"  style="width:140px;height:200px;">

        </div>
    </div>

        <div id="tabs" region="center" class="easyui-tabs"  fit="true" border="false"  style="width:400px;height:250px;!important;">
            <div title="Home">
                <table id="tt" class="easyui-datagrid" style="width:600px;height:250px"
                       url=""
                       title="Load Data" iconCls="icon-save"
                       rownumbers="true" pagination="true">
                    <thead>
                    <tr>
                        <th field="itemid" width="80">Item ID</th>
                        <th field="productid" width="80">Product ID</th>
                        <th field="listprice" width="80" align="right">List Price</th>
                        <th field="unitcost" width="80" align="right">Unit Cost</th>
                        <th field="attr1" width="150">Attribute</th>
                        <th field="status" width="60" align="center">Stauts</th>
                    </tr>
                    </thead>
                </table>
            </div>
</div>
</div>

<#--<div class="easyui-layout" style="width: 100%;height: 800px;">
<!--顶部header&ndash;&gt;
<div id="headPanle" region="north" title="" style="overflow:hidden;">
    <div style="height: 300px;background-color: #00bbee"></div>
&lt;#&ndash;    <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
    </div>&ndash;&gt;
</div>


<!--左侧导航栏&ndash;&gt;
<div id="leftPanle" region="west" title="" style="overflow:hidden;">

    <div style="height:400px;width:200px;background-color: #777777"></div>
    <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
    </div>
</div>

<!--主工作区&ndash;&gt;
    <div id="content" region="center" title="Language" style="padding:5px;background-color:#00bbee">
&lt;#&ndash;<div id="mainPanle" region="center" title="" style="overflow:hidden;">
    <div style="height:400px;width:200px;background-color:#00bbee"><p>1111111111</p></div>
 &lt;#&ndash;   <div id="tabs" class="easyui-tabs"  fit="true" border="false" >

    </div>&ndash;&gt;
</div>&ndash;&gt;

    <!--根&ndash;&gt;
    <div id="footPanle" region="south" title="" style="overflow:hidden;">

        <div style="height:100px;width:100%;background-color: #777777"></div>
    </div>
</div>
   </div>-->


    <script type="text/javascript">
        var _menus1 = [
            {
                "menuid": "1", "icon": "icon-ok", "menuname": "权限管理",
                "menus": [
                    { "menuid": "13", "menuname": "用户管理", "icon": "icon-user", "url": "/User/Index" },
                    { "menuid": "14", "menuname": "组织机构管理", "icon": "icon-organ", "url": "/OU/Index" },
                    { "menuid": "15", "menuname": "角色管理", "icon": "icon-group-key", "url": "/Role/Index" },
                    { "menuid": "16", "menuname": "功能管理", "icon": "icon-key", "url": "/Function/Index" },
                    { "menuid": "17", "menuname": "登陆日志", "icon": "icon-view", "url": "/LoginLog/Index" }
                ]
            },
            {
                "menuid": "2", "icon": "icon-user", "menuname": "其他管理",
                "menus": [{ "menuid": "21", "menuname": "修改密码", "icon": "icon-lock", "url": "javascript:ShowPasswordDialog()" }
                ]
            }
        ];
        addMenu(_menus1);
     /*   $(function(){
         /!*   function showcontent(language){
                $('#content').html('Introduction to ' + language + ' language');
            };
            showcontent("111");*!/
          //  addMenu(_menus1);
            showSubMenu('', '用户管理', '','default')
        });*/



        var _menus = {
            "default": [
                {
                    "menuid": "1", "icon": "icon-computer", "menuname": "权限管理",
                    "menus": [
                        { "menuid": "13", "menuname": "用户管理", "icon": "icon-user", "url": "/User/Index" },
                        { "menuid": "14", "menuname": "组织机构管理", "icon": "icon-organ", "url": "/OU/Index" },
                        { "menuid": "15", "menuname": "角色管理", "icon": "icon-group-key", "url": "/Role/Index" },
                        { "menuid": "16", "menuname": "功能管理", "icon": "icon-key", "url": "/Function/Index" },
                        { "menuid": "17", "menuname": "登陆日志", "icon": "icon-view", "url": "/LoginLog/Index" }
                    ]
                },
                {
                    "menuid": "2", "icon": "icon-user", "menuname": "其他管理",
                    "menus": [{ "menuid": "21", "menuname": "修改密码", "icon": "icon-lock", "url": "javascript:ShowPasswordDialog()" }
                    ]
                }
            ],
            "point": [
                {
                    "menuid": "3", "icon": "icon-computer", "menuname": "事务中心",
                    "menus": [
                        { "menuid": "33", "menuname": "测试菜单1", "icon": "icon-user", "url": "../Commonpage/building.htm" },
                        { "menuid": "34", "menuname": "测试菜单2", "icon": "icon-organ", "url": "../Commonpage/building.htm" },
                        { "menuid": "35", "menuname": "测试菜单3", "icon": "icon-group-key", "url": "../Commonpage/building.htm" },
                        { "menuid": "36", "menuname": "测试菜单4", "icon": "icon-key", "url": "../Commonpage/building.htm" }
                    ]
                },
                {
                    "menuid": "4", "icon": "icon-user", "menuname": "其他菜单",
                    "menus": [{ "menuid": "41", "menuname": "测试菜单5", "icon": "icon-lock", "url": "../Commonpage/building.htm" }]
                }
            ]
        };




        function showSubMenu(url, title, menuCategory, defaultIcon) {
            if (defaultIcon == null || defaultIcon == "") {
                defaultIcon = "icon-table";
            }
         //   addTab("tabs",title, url, "icon " + defaultIcon);
//addMenu(_menus1);

       /*     Clearnav();
            if (menuCategory != "") {
                addNav(_menus[menuCategory]);
            }*/
        }

        function addMenu(_menu){
for(var i=0;i<_menu.length;i++){
    var div='<div  title="'+_menu[i].menuname+'" iconCls="'+_menu[i].icon+'" style="overflow:auto;padding:10px;" >';

    for(var j=0;j<_menu[i].menus.length;j++){
        div+='<p>'+_menu[i].menus[j].menuname+'</p>';
    }
   div+="</div>";
    $('.easyui-accordion').append(div);
    //$('.easyui-accordion').append(div);
}

        }



        function addTab(_id,_title,_url,_icon){
            if ($("#"+_id).tabs('exists', _title)){
                $("#"+_id).tabs('select', _title);
            } else {
                var content = '<iframe scrolling="auto" frameborder="0"  src="'+_url+'" style="width:100%;height:100%;"></iframe>';
                $("#"+_id).tabs('add',{
                    title:_title,
                    content:content,
                    closable:true
                });
            }
        }
        </script>
</body>
</html>
<#--
<!--tab上菜单&ndash;&gt;
<div id="mainPanle" region="north" title="" style="overflow:hidden;">
    <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
    </div>
</div>-->
