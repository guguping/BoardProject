## 51일차
## 비로그인 게시판 만들기

```sql
drop table if exists board_table;
create table board_table(
id bigint auto_increment primary key,
boardWriter varchar(50),
boardPass varchar(20),
boardTitle varchar(50),
boardContents varchar(500),
boardCreateDate datetime default now(),
boardHits int
);

insert into board_table(boardWriter,boardPass,boardTitle,boardContents) value('아무나','1234','아무나1','일단틀어');
select * from board_table;
```
### Class HomeController , BoardService ,BoardRepository,BoardDTO

### 시작페이지 , 글작성페이지 , 글목록 , 상세보기 , 수정 , 삭제 , 검색 만듬

## 52일차
### ing
```sql
drop table if exists board_file_table;
create table board_file_table(
id bigint primary key auto_increment,
originalFileName varchar(100),
storedFileName varchar(100),
boardId bigint,
constraint fk_board_file foreign key (boardId) references board_table(id)
);
```
### 조회수 증가 만듬 detail



