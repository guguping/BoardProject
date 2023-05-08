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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>boardDetail</title>
    <link rel="stylesheet" href="/resources/css/style.css">
    <script src="//cdn.ckeditor.com/4.21.0/standard/ckeditor.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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
            <td colspan="6"><textarea id="editor1" name="boardContents"
                                      COLS="104" ROWS="38" readonly>${boardDTO.boardContents}</textarea></td>
        </tr>
        <tr>
            <th colspan="6">댓글</th>
        </tr>
        <c:choose>
            <c:when test="${cList == null}">
                <tr>
                    <th colspan="6">
                        <h1>아직 작성된 댓글이 없습니다</h1>
                    </th>
                </tr>
            </c:when>
            <c:otherwise>
                <tr>
                    <th>id</th>
                    <th>작성자</th>
                    <th>내용</th>
                    <th>작성시간</th>
                </tr>
                <c:forEach items="${cList}" var="cList">
                    <tr>
                        <td>${cList.id}</td>
                        <td>${cList.commentWriter}</td>
                        <td>${cList.commentContents}</td>
                        <td>
                            <fmt:formatDate value="${cList.commentCreatedDate}"
                                            pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <tr id="commentResult">

        </tr>
        <tr>
            <th colspan="6"><label for="commentWriter" style="float: left">작성자: </label>
                <input type="text" name="commentWriter" id="commentWriter" style="float: left">
                <label for="commentContents" style="margin-right: 187px">내용</label>
                <input type="button" value="등록" style="float: right" onclick="helloComment(${boardDTO.id})"></th>
        </tr>
        <tr>
            <td colspan="6"><textarea id="commentContents" COLS="104" ROWS="5"></textarea></td>
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
    const helloComment = (id) => {
        const commentWriter = document.getElementById('commentWriter').value;
        const commentContents = document.getElementById('commentContents').value;
        const boardId = id;
        const commentResult = document.getElementById('commentResult');
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                "commentWriter": commentWriter,
                "commentContents": commentContents,
                "boardId": boardId
            },
            success: function (res) {
                let output;
                for (let i in res) {
                    output += "<td>" + res[i].id + "</td>";
                    output += "<td>" + res[i].commentWriter + "</td>";
                    output += "<td>" + res[i].commentContents + "</td>";
                    output += "<td>" + moment(res[i].commentCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "</td>";
                }
                commentResult.innerHTML = output;
                document.getElementById('commentWriter').innerHTML = "";
                document.getElementById('commentContents').innerHTML = "";
            },
            error: function () {
                console.log("실패");
            }
        })

    }
    CKEDITOR.replace('editor1');
</script>
</html>
