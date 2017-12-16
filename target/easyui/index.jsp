<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.5/themes/icon.css">
    <script type="text/javascript" src="static/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        function getDatagrid(){

            $('#tabf').tabs('add',{
                title:'datagrid',
                href:'${ctx}/testList'
            });
        }


    </script>
</head>

<body>
<button onclick="getDatagrid()">通过datagrid获取数据</button>
<div id="tabf"  class="easyui-tabs" style='width: 320px;height: 350px'>

</div>
</body>

</html>
