<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <h2 style="text-align: center">boardList</h2>
        <table>
            <tr>
                <th>글번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성시간</th>
                <th>조회수</th>
            </tr>
            <c:forEach items="${bList}" var="s">
                <tr>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a style="text-decoration: none;color: black" href="/board?id=${s.id}">${s.id}</a></td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a style="text-decoration: none;color: black" href="/board?id=${s.id}">${s.boardTitle}</a></td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a style="text-decoration: none;color: black" href="/board?id=${s.id}">${s.boardWriter}</a></td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a style="text-decoration: none;color: black" href="/board?id=${s.id}">
                            <fmt:formatDate value="${s.boardCreateDate}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                        </a></td>
                    <td style="border: 1px solid black;text-align: center;padding: 5px">
                        <a STYLE="text-decoration: none;color: black">${s.boardHits}</a></td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="6" style="padding: 5px;text-align: center">
                    <select id="optionResult">
                        <option value="">선택해주세요</option>
                        <option value="boardTitle" id="boardTitle">제목</option>
                        <option value="boardWriter" id="boardWriter">작성자</option>
                        <option value="boardContents" id="boardContents">내용</option>
                    </select>
                    <input type="text" placeholder="입력" id="searchResult">
                    <input type="button" value="검색" onclick="search()">
                </td>
            </tr>
        </table>
        <a href="/" style="text-decoration: none">index이동</a>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const search = () => {
        const optionResult = document.getElementById('optionResult');
        const searchResult = document.getElementById('searchResult');
        const Title = document.getElementById('boardTitle');
        const Writer = document.getElementById('boardWriter');
        const Contents = document.getElementById('boardContents');
        if (optionResult.value == "boardTitle") {
            Title.value = searchResult.value;
            console.log("Title," + Title.value);
            location.href = "/board/searchList?Title=" + Title.value + "&Writer=" + Writer.value + "&Contents=" + Contents.value;
        } else if (optionResult.value == "boardWriter") {
            Writer.value = searchResult.value;
            console.log("Writer," + Writer.value);
            location.href = "/board/searchList?Writer=" + Writer.value + "&Title=" + Title.value + "&Contents=" + Contents.value;
        } else if (optionResult.value == "boardContents") {
            Contents.value = searchResult.value;
            console.log("Contents," + Contents.value);
            location.href = "/board/searchList?Contents=" + Contents.value + "&Writer=" + Writer.value + "&Title=" + Title.value;
        }
    }
</script>
</html>
