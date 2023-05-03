<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-03
  Time: 오후 4:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>boardDelete</title>
</head>
<body>
<form action="/board/delete?id=${boardDTO.id}" method="post" id="deleteForm">
<input type="text" placeholder="비밀번호 확인" id="passwordResult">
<input type="submit" value="확인">
</form>
</body>
<script>
    const deleteFrom = document.getElementById('deleteForm');
    const passwordResult = document.getElementById('passwordResult');
    deleteFrom.addEventListener("submit",function (e){
        e.preventDefault();
        if(passwordResult.value != ${boardDTO.boardPass}){
            alert("비밀번호가 틀립니다");
        }else{
            alert("삭제 완료!")
            deleteFrom.submit();
        }
    })
</script>
</html>
