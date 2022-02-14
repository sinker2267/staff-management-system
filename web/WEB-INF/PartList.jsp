<%--
  Created by IntelliJ IDEA.
  User: 17864
  Date: 2022/2/12
  Time: 22:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
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

<table id="partList" class="layui-table" style="text-align:center;vertical-align:middle;" >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th width="300px" style="text-align:center;vertical-align:middle;">id</th>
        <th width="300px" style="text-align:center;vertical-align:middle;">部门名称</th>
        <th width="300px" style="text-align:center;vertical-align:middle;">部门主管</th>
        <th width="300px" style="text-align:center;vertical-align:middle;">操作</th>
    </tr>
    </thead>
    <c:forEach items="${requestScope.part}" var="part">
        <tr>
            <td>${part.id}</td>
            <td id="partName">${part.partName}</td>
            <td id="partLeader">${part.partLeader}</td>
            <td class="layui-btn-group" style="width: 300px">
                <a class="layui-btn layui-btn-primary layui-btn-sm" onclick="edit('PartServlet?method=selectById&id='+${part.id})"><i class="layui-icon">&#xe642;</i></a>
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
            <label class="layui-form-label">部门名称</label>
            <div class="layui-input-block">
                <input type="text" id="bid" name="bid" lay-verify="title" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">部门主管</label>
            <div class="layui-input-block">
                <input type="text" id="bname" name="bname" lay-verify="title"  class="layui-input">
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
        $.ajax({
            url: Path,
            type: "POST",
            dataType:"json",
            success:function (str){
                //console.log("haoye");
                $('#bid').val(str.partName);
                $('#bname').val(str.partLeader);
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
</script>
</body>
</html>

