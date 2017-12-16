<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%--    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5/themes/icon.css">
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/jquery-easyui-1.5/easyloader.js'"></script>--%>
</head>

<body>
<table id="dataGridTable" >

</table>
<script type="text/javascript">

    $(function() {
        var editRow = undefined;
        $('#dataGridTable').datagrid({
            width: 800,
            height: 800,
            fitColumns: false,
            nowrap: false,
            collapsible: true,
            collapsed: false ,
            url:"${ctx}/getData", //数据来源
            pagination : true,
            pageSize : 10,//这里后台也没有分页之类的的
            pageList : [ 10, 20, 30, 40, 50, 100 ],
            columns : [ [
                {
                    title : '性别',
                    field : 'sex',
                    align :'left',
                    width : 60,
                    sortable : true,
                    formatter : function(value){
                        if (value=='1'){
                            return '男';
                        }else if(value=='0'){
                            return '女';
                        }else if(value==''||value==null){
                            return '人妖';
                        }else{
                            return value;
                        }
                    },
                    styler:function(value){
                        if (value==null||value==''||value=='0'){
                            return 'color:red;';
                        }else {
                            return 'color:green;';
                        }
                    }
                },
                {
                    title : '姓名',
                    field : 'name',
                    align :'left',
                    width : 160,
                    sortable : true
                },
                {
                    title : '年龄',
                    field : 'age',
                    align :'center',
                    width : 80,
                    sortable : true
                }
            ] ],
            toolbar: [{
                text: '添加', iconCls: 'icon-add', handler: function () {
                    if (editRow != undefined) {
                        $("#dataGridTable").datagrid('endEdit', editRow);
                    }
                    if (editRow == undefined) {
                        $("#dataGridTable").datagrid('insertRow', {
                            index: 0,
                            row: {}
                        });

                        $("#dataGridTable").datagrid('beginEdit', 0);
                        editRow = 0;
                    }
                }
            }, '-', {
                text: '保存', iconCls: 'icon-save', handler: function () {
                    $("#dataGridTable").datagrid('endEdit', editRow);

                    //如果调用acceptChanges(),使用getChanges()则获取不到编辑和新增的数据。

                    //使用JSON序列化datarow对象，发送到后台。
                    var rows = $("#dataGridTable").datagrid('getChanges');

                    var rowstr = JSON.stringify(rows);
                    $.post('/Home/Create', rowstr, function (data) {

                    });
                }
            }, '-', {
                text: '撤销', iconCls: 'icon-redo', handler: function () {
                    editRow = undefined;
                    $("#dataGridTable").datagrid('rejectChanges');
                    $("#dataGridTable").datagrid('unselectAll');
                }
            }, '-', {
                text: '删除', iconCls: 'icon-remove', handler: function () {
                    var row = $("#dataGridTable").datagrid('getSelections');

                }
            }, '-', {
                text: '修改', iconCls: 'icon-edit', handler: function () {
                    var row = $("#dataGridTable").datagrid('getSelected');
                    if (row !=null) {
                        if (editRow != undefined) {
                            $("#dataGridTable").datagrid('endEdit', editRow);
                        }

                        if (editRow == undefined) {
                            var index = $("#dataGridTable").datagrid('getRowIndex', row);
                            $("#dataGridTable").datagrid('beginEdit', index);
                            editRow = index;
                            $("#dataGridTable").datagrid('unselectAll');
                        }
                    } else {

                    }
                }
            }, '-', {
                text: '上移', iconCls: 'icon-up', handler: function () {
                    MoveUp();
                }
            }, '-', {
                text: '下移', iconCls: 'icon-down', handler: function () {
                    MoveDown();
                }
            }],
            onDblClickRow : function(rowIndex, rowData) {
                alert("点击row");
            }
        });
    });


</script>
</body>

</html>