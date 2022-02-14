<%--
  Created by IntelliJ IDEA.
  User: 17864
  Date: 2022/2/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all">
</head>
<body>
<form class="layui-form" onsubmit="return false">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input id="inputName" type="text" name="title" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-inline">
            <input id="inputPsd" type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">联系方式</label>
        <div class="layui-input-block">
            <input id="inputMoblie" type="text" name="title" required  lay-verify="required" placeholder="请输入联系方式" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所属部门</label>
        <div class="layui-input-block">
            <input id="inputPart" type="text" name="title" required  lay-verify="required" placeholder="请输入部门" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="add()">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary" onclick="resetadd()">重置</button>
        </div>
    </div>
</form>
</body>
<script src="${pageContext.request.contextPath}/static/assets/libs/jquery-1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
    var form = document.getElementsByTagName('form')[0];
    form.addEventListener('submit',function(e){
        e.preventDefault();
    });
    function add(){
        var inputName = $("#inputName").val();
        var inputPsd = $("#inputPsd").val();
        var inputMoblie = $("#inputMoblie").val();
        var inputPart = $("#inputPart").val();
        $.ajax({
            url:"UserServlet?method=addStaff",
            type: "POST",
            data:{"inputName":inputName,"inputPsd":inputPsd,"inputMoblie":inputMoblie,"inputPart":inputPart},
            dataType:"json",
            success:function (str){
                window.location.href="UserServlet?method=ToStaffList";
            },
            error:function (){
                console.log("error");
            }
        })
    }
    function resetadd(){
        layer.msg(JSON.stringify(data.field));
        return false;
    }
</script>
</html>
