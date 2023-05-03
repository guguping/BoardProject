<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-03
  Time: 오전 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>boardSave</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2>나는야 세이브</h2>
        <form action="/board/save" method="post">
            <table>
                <tr>
                    <th></th>
                    <th><label for="boardWriter">작성자:</label></th>
                    <td><input type="text" id="boardWriter" name="boardWriter"></td>
                    <th><label for="boardPass">글비밀번호:</label> </th>
                    <td><input type="text" id="boardPass" name="boardPass"></td>
                    <th><label for="boardTitle">글제목</label></th>
                    <td><input type="text" id="boardTitle" name="boardTitle"></td>
                <tr>
                    <th><label for="boardContents">내용</label></th>
                    <td colspan="6"><textarea id="boardContents" name="boardContents" COLS="102" ROWS="40"></textarea></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <input type="submit" style="display: inline" value="등록">
                        <input type="button" style="display: inline" value="취소" onclick="goindex()">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const goindex = () => {
      location.href = "/";
    }
</script>
</html>
