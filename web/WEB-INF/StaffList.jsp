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
        <th width="300px" style="text-align:center;vertical-align:middle;">id</th>
        <th width="300px" style="text-align:center;vertical-align:middle;">姓名</th>
        <th width="300px" style="text-align:center;vertical-align:middle;">联系方式</th>
        <th width="300px" style="text-align:center;vertical-align:middle;">所属部门</th>
    </tr>
    </thead>
    <c:forEach items="${requestScope.user}" var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.userName}</td>
            <td>${user.userMoblie}</td>
            <td>${user.part}</td>
        </tr>
    </c:forEach>
    <tbody>
    </tbody>
</table>

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
</body>
</html>
