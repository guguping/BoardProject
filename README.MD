## 51일차
## 비로그인 게시판 만들기

```sql
drop table if exists board_table;
create table board_table
(
    id              bigint auto_increment primary key,
    boardWriter     varchar(50),
    boardPass       varchar(20),
    boardTitle      varchar(50),
    boardContents   varchar(500),
    boardCreateDate datetime default now(),
    boardHits       int      default 0,
    fileAttached    int      default 0
);

insert into board_table(boardWriter, boardPass, boardTitle, boardContents) value('아무나','1234','아무나1','일단틀어');
select * from board_table;
```
### Class HomeController , BoardService ,BoardRepository,BoardDTO

### 시작페이지 , 글작성페이지 , 글목록 , 상세보기 , 수정 , 삭제 , 검색 만듬

## 52일차
### ing

### 조회수 증가 만듬 detail
### 파일 함께 보내기
```Html
<form action="/board/save" method="post" enctype="multipart/form-data">

    <input type="file" name="boardFile" value="파일첨부"></td>
</form>
```
####  enctype="multipart/form-data" 을 꼭붙여주어야합니다

```sql
drop table if exists board_file_table;
create table board_file_table
(
    id               bigint primary key auto_increment,
    originalFileName varchar(100),
    storedFileName   varchar(100),
    boardId          bigint,
    constraint fk_board_file foreign key (boardId) references board_table (id) on delete cascade
);
select * from board_file_table;
```
#### 받아온 파일을 DTO에 받아줄거라면 MultipartFile타입의 필드가 필요하다

useGeneratedKeys="true" = 자동으로 생성되는 값이 있을때 
keyProperty="id" = 해당 컬럼 이름

#### BoardSave메소드 전체 수정 Controller , Service , Repository , Mapper , mybatis
#### 전체 싹다 수정함

### ck에디터 적용 save

## day 53 - 코멘트기능
```sql
drop table if exists comment_table;
create table comment_table(
id bigint primary key auto_increment,
commentWriter varchar(50),
commentContents varchar(500),
boardId bigint,
commentCreatedDate datetime default now(),
constraint fk_comment foreign key (boardId) references board_table(id) on delete cascade
);

select * from comment_table;
```
### jquery 사용했음 , 모멘트 라이브러리 사용했음
```javascript
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
```

## 페이징처리
``` sql
-- 페이징 처리를 위한 쿼리문
-- 한페이지에 게시글 10개씩
select * from board_table order by id asc limit 0,9;
select * from board_table order by id asc limit 9,9;
select * from board_table order by id asc limit 18,9;
select * from board_table order by id asc limit 27,9;
select * from board_table order by id asc limit 36,9;
```
#### boardSerivce의 pagingList 참고 sql문법

## day 54 - 검색, 검색결과 페이징
### boardPaging부터 시작함

```sql
select * from board_table where boardTitle like '%아%' order by id asc limit 0,3;
MySQL에서는 like연산자를 사용할때 '%아%'를 사용했지만

select count(id) from board_table where boardTitle like concat('%', #{q}, '%')
Mapper에서 사용을 할때 '%아%'로 작성하면 잘 작동하지 않기 때문에
 concat을 사용하여 concat('%', #{q}, '%')이런 식으로 붙여 사용한다

```


```sql
    <select id="searchCount" parameterType="java.util.HashMap" resultType="Integer">
        select count(id) from board_table where ${tpye} like concat('%', #{q}, '%')
                            마이바티스 문법 컬럼 부분이 변해야하는 경우 ${} 사용가능
                        원래는 case를 사용하였지만 이게 더 가독성이 좋고 편하기에 이걸 사용
    </select>
```