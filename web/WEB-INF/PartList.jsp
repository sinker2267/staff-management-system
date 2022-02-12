<%--
  Created by IntelliJ IDEA.
  User: 17864
  Date: 2022/2/12
  Time: 22:42
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
        <th width="400px" style="text-align:center;vertical-align:middle;">id</th>
        <th width="400px" style="text-align:center;vertical-align:middle;">部门名称</th>
        <th width="400px" style="text-align:center;vertical-align:middle;">部门主管</th>
    </tr>
    </thead>
    <c:forEach items="${requestScope.part}" var="part">
        <tr>
            <td>${part.id}</td>
            <td>${part.partName}</td>
            <td>${part.partLeader}</td>
        </tr>
    </c:forEach>
    <tbody>
    </tbody>
</table>
</body>
</html>
