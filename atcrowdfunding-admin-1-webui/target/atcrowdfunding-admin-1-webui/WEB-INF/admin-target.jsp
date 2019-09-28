
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>admin-target</title>
</head>
<body>
    <h1>admin-target</h1>
    <c:if test="${!empty list}">
        <c:forEach items="${list}" var="admin">
            ${admin}<br>
        </c:forEach>
    </c:if>
</body>
</html>
