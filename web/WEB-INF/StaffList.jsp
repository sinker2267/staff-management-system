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
<form class="layui-form" onsubmit="return false">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-inline" style="width: 250px;">
            <input id="inputName" type="text" name="title"   lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">联系方式</label>
        <div class="layui-input-inline" style="width: 250px;">

            <input id="inputMoblie" type="text" name="title"   lay-verify="required" placeholder="请输入联系方式" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">所属部门</label>
        <div class="layui-input-inline" style="width: 250px;">
            <input id="inputPart" type="text" name="title"   lay-verify="required" placeholder="请输入所属部门" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-input-inline">
            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="select()">立即查询</button>
        </div>
    </div>
</form>
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
                <a class="layui-btn layui-btn-primary layui-btn-sm" onclick="del('UserServlet?method=deleteById&id='+${user.id})"><i class="layui-icon">&#xe640;</i></a>
            </td>
        </tr>
    </c:forEach>
    <tbody>
    </tbody>
</table>
<div class="site-text" style="margin: 5%; display: none" id="window" >
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
                $('#bid').val(str.userName);
                $('#bname').val(str.userMoblie);
                $('#bpart').val(str.part);
                var userId = str.id;
                layui.use(['layer','form'], function(){
                    layer.open({
                        type:1,
                        area:['500px','400px'],
                        title: '编辑用户'
                        ,content: $("#window"),
                        shade: 0,
                        btn: ['提交', '重置']
                        ,btn1: function(index, layero){
                            var userName = $('#bid').val();
                            var userMobile = $('#bname').val();
                            var userPart = $('#bpart').val();
                            var path = "UserServlet?method=updateStaff&userId="+userId+"&userName="+userName+"&userMobile="+userMobile+"&uaerPart="+userPart;
                            window.location.href = path;
                            alert("编辑成功");
                        },
                        btn2: function(index, layero){
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
    function del(Path){
        layui.use(['layer','form'], function(){
            layer.open({
                type:1,
                area:['500px','400px'],
                title: '删除用户'
                ,content: "删除后无法恢复，确定要删除吗",
                shade: 0,
                btn: ['确定', '取消']
                ,btn1: function(index, layero){
                    window.location.href = Path;
                    alert("删除成功");
                },
                btn2: function(index, layero){
                    return false;
                },
                cancel: function(layero,index){
                    layer.closeAll();
                }
            });
        })
    }
    function select(){
        var inputName = $("#inputName").val();
        var inputMoblie = $("#inputMoblie").val();
        var inputPart = $("#inputPart").val();
        $.ajax({
            url: "UserServlet?method=selectUser",
            type: "POST",
            dataType:"json",
            data:{"inputName":inputName,"inputMoblie":inputMoblie,"inputPart":inputPart},
            success:function (str){
                window.location.reload();
            },
            error:function (){
                console.log("error");
            }
        })

    }
</script>
</body>
</html>
