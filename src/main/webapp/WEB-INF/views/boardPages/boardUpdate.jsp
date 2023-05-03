<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-03
  Time: 오후 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>boardUpdate</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <form action="/board/update?id=${boardDTO.id}" id="updateForm" method="post">
        <table>
            <tr>
                <th colspan="6">제목</th>
            </tr>
            <tr>
                <th colspan="6"><textarea cols="102" name="boardTitle">${boardDTO.boardTitle}</textarea></th>
            </tr>
            <tr>
                <th></th>
                <th>글번호</th>
                <th>작성자</th>
                <th>작성시간</th>
                <th>조회수</th>
            </tr>
            <tr>
                <th></th>
                <th>${boardDTO.id}</th>
                <th>${boardDTO.boardWriter}</th>
                <th>${boardDTO.boardCreateDate}</th>
                <th>${boardDTO.boardHits}</th>
            </tr>
            <tr>
                <td colspan="6"><textarea name="boardContents"
                                          COLS="102" ROWS="38">${boardDTO.boardContents}</textarea></td>
            </tr>
            <tr>
                <th colspan="6">
                    <input type="submit" value="수정">
                    <input type="button" value="취소" onclick="goDetail(${boardDTO.id})">
                </th>
            </tr>
        </table>
    </form>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const goDetail = (id) => {
      location.href = "/board?id="+id;
    }
    const updateForm = document.getElementById('updateForm');
    updateForm.addEventListener("submit",function (e){
    e.preventDefault();
    let promptResult = prompt("기존 비밀번호 확인", "입력바랍니다");
    if('${boardDTO.boardPass}' != promptResult){
        alert("비밀번호가 틀립니다");
    }else{
        alert("수정 완료!");
        updateForm.submit();
    }
    })
</script>
</html>