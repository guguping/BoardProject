<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-04-28
  Time: 오후 2:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2 style="text-align: center">boardPagingList</h2>
        <table class="table table-striped table-hover text-center">
            <thead>
            <tr>
                <th>글번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성시간</th>
                <th>조회수</th>
            </tr>
            <c:forEach items="${boardList}" var="board">
                <tr>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a href="/board?id=${board.id}&page=${paging.page}"
                           style="text-decoration: none;color: black">${board.id}</a>
                    </td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a href="/board?id=${board.id}&page=${paging.page}"
                           style="text-decoration: none;color: black">${board.boardTitle}</a>
                    </td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a href="/board?id=${board.id}&page=${paging.page}"
                           style="text-decoration: none;color: black">${board.boardWriter}</a>
                    </td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a href="/board?id=${board.id}&page=${paging.page}"
                           style="text-decoration: none;color: black"><fmt:formatDate value="${board.boardCreateDate}"
                                                                                      pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></a>
                    </td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a href="/board?id=${board.id}&page=${paging.page}"
                           style="text-decoration: none;color: black">${board.boardHits}</a>
                    </td>
                </tr>
            </c:forEach>
            </thead>
            <tbody>
            <tr>
                <th colspan="5" style="padding: 5px"><c:choose>
                    <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                    <c:when test="${paging.page<=1}">
                        <a class="page-link" style="text-decoration: none;color: grey">[이전]</a>
                    </c:when>
                    <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                    <c:otherwise>
                        <a class="page-link" href="/board/paging?page=${paging.page-1}"
                           style="text-decoration: none;color: black">[이전]</a>
                    </c:otherwise>
                </c:choose>
                    <%--  for(int i=startPage; i<=endPage; i++)      --%>
                    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                        <c:choose>
                            <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                            <%--                    eq == && --%>
                            <c:when test="${i eq paging.page}">
                                <a class="page-link" style="text-decoration: none;color: violet">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a class="page-link" href="/board/paging?page=${i}"
                                   style="text-decoration: none;color: black">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${paging.page>=paging.maxPage}">
                            <a class="page-link" style="text-decoration: none;color: grey">[다음]</a>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/board/paging?page=${paging.page+1}"
                               style="text-decoration: none;color: black">[다음]</a>
                        </c:otherwise>
                    </c:choose></th>
            </tr>
            </tbody>
        </table>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
</html>