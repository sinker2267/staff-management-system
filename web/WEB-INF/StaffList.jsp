<%--
  Created by IntelliJ IDEA.
  User: 17864
  Date: 2022/2/12
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>table模块快速使用</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body>

<table class="layui-table" style="text-align:center;vertical-align:middle;">
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th width="240px" style="text-align:center;vertical-align:middle;">id</th>
        <th width="240px" style="text-align:center;vertical-align:middle;">姓名</th>
        <th width="240px" style="text-align:center;vertical-align:middle;">联系方式</th>
        <th width="240px" style="text-align:center;vertical-align:middle;">所属部门</th>
        <th width="240px" style="text-align:center;vertical-align:middle;">操作</th>
    </tr>
    </thead>
    <c:forEach items="${requestScope.user}" var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.userName}</td>
            <td>${user.userMoblie}</td>
            <td>${user.part}</td>
            <td class="layui-btn-group" style="width: 300px">
                <a class="layui-btn layui-btn-primary layui-btn-sm" onclick="edit('UserServlet?method=selectById&id='+${user.id})"><i class="layui-icon">&#xe642;</i></a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" ><i class="layui-icon">&#xe640;</i></a>
            </td>
        </tr>
    </c:forEach>
    <tbody>
    </tbody>
</table>
<div class="site-text" style="margin: 5%; display: none" id="window"  t>
    <form class="layui-form" id="book"  lay-filter="example" onsubmit="return false">
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text" id="bid" name="bid" lay-verify="title" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-input-block">
                <input type="text" id="bname" name="bname" lay-verify="title" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-block">
                <input type="text" id="bpart" name="bpart" lay-verify="title" class="layui-input">
            </div>
        </div>
    </form>
</div>

<script src="${pageContext.request.contextPath}/static/assets/libs/jquery-1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
    // layui.use('table', function(){
    //     var table = layui.table;
    //
    //     //第一个实例
    //     table.render({
    //         elem: '#demo'
    //         ,url: "/findAll"
    //         ,height: 312
    //         ,page: true //开启分页
    //         ,cols: [[ //表头
    //             {field: 'id', title: 'ID', width:400, sort: true, fixed: 'left'}
    //             ,{field: 'name', title: '用户名', width:500}
    //             ,{field: 'moblie', title: '联系方式', width:500}
    //         ]]
    //     });
    //
    // });
</script>
<script>
    var form = document.getElementsByTagName('form')[0];
    form.addEventListener('submit',function(e){
        e.preventDefault();
    });
    function edit(Path){
        <%--        ${requestScope.put("id",PartId)}--%>
        <%--        console.log('${requestScope.id}')--%>
        $.ajax({
            url: Path,
            type: "POST",
            dataType:"json",
            success:function (str){
                //console.log("haoye");
                $('#bid').val(str.userName);
                $('#bname').val(str.userMoblie);
                $('#bpart').val(str.part);
                //console.log(str.partName);
                layui.use(['layer','form'], function(){
                    layer.open({
                        type:1,
                        area:['500px','400px'],
                        title: '编辑部门'
                        ,content: $("#window"),
                        shade: 0,
                        btn: ['提交', '重置']
                        ,btn1: function(index, layero){
                            var kk=$("#username").val();
                            alert(kk);
                        },
                        btn2: function(index, layero){
                            alert("2222");
                            return false;
                        },

                        cancel: function(layero,index){
                            layer.closeAll();
                        }
                    });
                })

            },
            error:function (){
                console.log("error");
            }
        });

    }
    // <a class="layui-btn layui-btn-mini" lay-event="detail">查看</a>
    // <a class="layui-btn layui-btn-mini layui-btn-normal" lay-event="edit">编辑</a>
    // <a class="layui-btn layui-btn-mini layui-btn-danger" lay-event="del">删除</a>
</script>
</body>
</html>
