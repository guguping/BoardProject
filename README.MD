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
### jquery 사용했음 , 모멘트 라이브러리 사용했음
```javascript
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
```

