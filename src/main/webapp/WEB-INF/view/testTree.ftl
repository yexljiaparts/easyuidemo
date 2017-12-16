<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>type</title>
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/icon.css">
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<#--    <script type="text/javascript" src="/static/jquery-easyui-1.5/easyloader.js'"></script>-->
</head>
<body>

    <!-- 递归  宏定义 -->
<#macro bpTree children>
    <#if children?? && children?size gt 0>
        <#list children as child>
            <#if child.children?? && child.children?size gt 0>
                <div class="treeview">
                    <a href="javascript:void(0)">
                     <span>${child.type.typeName}</span>
                        <i class="fa fa-angle-left pull-right" aria-hidden="true"></i>
                    </a>
                    <div class="treeview-menu">
                        <@bpTree children=child.children />
                    </div>
                </div>
            <#else>
                <div><a href="javascript:void(0)" > ${child.type.typeName}</a></div>
            </#if>
        </#list>
    </#if>
</#macro>
    <!-- 调用宏 生成递归树 -->
    <div id="mm" class="easyui-menu" style="width:120px;height: 70px;display: block !important;">
    <@bpTree children=types />
        </div>

</body>
</html>





<#--
<#macro typeChilden items>
    <#assign countSize = items?size>
<ul>
    <#list items as item>
        <li>${item.type.typeName}
            <#if item.children?? && item.children?size gt 0>

            <@typeChilden item.children></@typeChilden>

        </#if>
        </li>

    </#list>
</ul>
</#macro>
<br>
<ul>
<#list types as item>
    <li>
    ${item.type.typeName!''}
        <#if item.children?? && item.children?size gt 0 >
        <@typeChilden item.children></@typeChilden>
    </#if>
    </li>
</#list>
</ul>-->
