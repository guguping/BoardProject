<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-03
  Time: 오전 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>boardList</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2>boardList</h2>
        <table>
            <tr>
                <th>글번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성시간</th>
            </tr>
            <c:forEach items="${bList}" var="s">
                <tr>
                    <td>${s.id}</td>
                    <td>${s.boardTitle}</td>
                    <td>${s.boardWriter}</td>
                    <td>${s.boardCreateDate}</td>
                </tr>
            </c:forEach>
        </table>
        <a href="/" style="text-decoration: none">index이동</a>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
</html>
