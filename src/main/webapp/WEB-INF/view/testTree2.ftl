<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>type</title>
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/icon.css">
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.min.js"></script>
</head>
<body>
<ul class="easyui-tree">
    <!-- 递归  宏定义 -->
<#macro bpTree children>
    <#if children?? && children?size gt 0>
        <#list children as child>
            <#if child.children?? && child.children?size gt 0>
                <li >

                     <span><a href="javascript:void(0)">${child.type.typeName}</a></span>

                    <ul >
                        <@bpTree children=child.children />
                    </ul>
                </li>
            <#else>
                <li><a href="javascript:void(0)"><span>${child.type.typeName}</span></a></li>
            </#if>
        </#list>
    </#if>
</#macro>
    <!-- 调用宏 生成递归树 -->
    <@bpTree children=types />
</ul>
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
