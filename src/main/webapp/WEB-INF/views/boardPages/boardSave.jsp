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
    <script src="//cdn.ckeditor.com/4.21.0/standard/ckeditor.js"></script>
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2 style="text-align: center;">나는야 세이브</h2>
        <form action="/board/save" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <th><label for="boardWriter">작성자:</label>
                        <input type="text" id="boardWriter" name="boardWriter"></th>
                    <th><label for="boardPass">글비밀번호:</label>
                        <input type="text" id="boardPass" name="boardPass"></th>
                    <th><label for="boardTitle">글제목</label>
                        <input type="text" id="boardTitle" name="boardTitle"></th>
                </tr>
                <tr>
                    <th colspan="6"><label for="editor1">내용</label>
                        <label for="boardFile" style="float: right">업로드</label>
                        <input type="file" id="boardFile" name="boardFile" multiple style="display: none"></th>
                </tr>
                <tr>
                    <td colspan="6"><textarea id="editor1" name="boardContents" COLS="104" ROWS="40"></textarea>
                    </td>
                </tr>
                <tr>
                    <th colspan="6">
                        <input type="submit" style="display: inline" value="등록">
                        <input type="button" style="display: inline" value="취소" onclick="goindex()">
                    </th>
                </tr>
            </table>
        </form>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    CKEDITOR.replace('editor1');
    const goindex = () => {
        location.href = "/";
    }
</script>
</html>
