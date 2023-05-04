<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-03
  Time: 오후 1:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>boardDetail</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <table>
        <tr>
            <th colspan="6">제목</th>
        </tr>
        <tr>
            <td colspan="6"><textarea cols="104" name="boardTitle" readonly>${boardDTO.boardTitle}</textarea></td>
        </tr>
        <tr>
            <th>글번호</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th>조회수</th>
        </tr>
        <tr>
            <th>${boardDTO.id}</th>
            <th>${boardDTO.boardWriter}</th>
            <th>
                <fmt:formatDate value="${boardDTO.boardCreateDate}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
            </th>
            <%--            <th>${boardDTO.boardCreateDate}</th>--%>
            <th>${boardDTO.boardHits}</th>
        </tr>
        <c:if test="${boardDTO.fileAttached == 1}">
            <tr>
                <th colspan="6">image</th>
            </tr>
            <tr>
                <td colspan="6">
                    <c:forEach items="${boardFileList}" var="boardFile">
                        <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt=""
                             style="width: 100px" ; height="100px">
                    </c:forEach>
                </td>
            </tr>
        </c:if>
        <tr>
            <td colspan="6"><textarea id="boardContents" name="boardContents"
                                      COLS="104" ROWS="38" readonly>${boardDTO.boardContents}</textarea></td>
        </tr>
        <tr>
            <th colspan="6">
                <input type="button" value="수정" onclick="goUpdate(${boardDTO.id})">
                <input type="button" value="삭제" onclick="goDelete(${boardDTO.id})">
                <input type="button" value="뒤로" onclick="goList()">
            </th>
        </tr>
    </table>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const goUpdate = (id) => {
        location.href = "/board/update?id=" + id;
    }
    const goDelete = (id) => {
        location.href = "/board/delete?id=" + id;
    }
    const goList = () => {
        location.href = "/board/";

    }
</script>
</html>
