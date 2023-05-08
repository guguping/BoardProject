package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.dto.PageDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    public void BoardSave(BoardDTO boardDTO) throws IOException {
        //파일 있음 , 없음 구분
        if (boardDTO.getBoardFile().get(0).isEmpty()) { // isEmpty = 파일이 비었다
            //파일 없음 .
            System.out.println("파일없음");
            boardDTO.setFileAttached(0);
            boardRepository.BoardSave(boardDTO);
        } else {
            // 파일 있음 .
//            1.파일첨부 여부 값 1로 세팅하고 db에 제목 등 내용 board_table에 저장
//            2.파일의 이름을 가져오고 DTO 필드값에 세팅
//            3.저장용 파일 이름 만들고 DTO 필드값에 세팅
//            4.로컬에 파일 저장
//            5.board_file_table에 저장 처리
            System.out.println("file on");
            boardDTO.setFileAttached(1);
            BoardDTO dto = boardRepository.BoardSave(boardDTO);
            for (MultipartFile boardFile : boardDTO.getBoardFile()) {
                // 원본 파일 이름 가져오기
                String originalFilename = boardFile.getOriginalFilename();
                System.out.println("originalFilename = " + originalFilename);
                // 저장용 이름 만들기
                System.out.println(System.currentTimeMillis());
                // 1970 1월 1일을 기준으로 현재까지의 몇미리초가 지났는지의 값
                System.out.println(UUID.randomUUID().toString());
                // 랜덤 난수를 만들어주는 메소드
                String storedFileName = System.currentTimeMillis() + "-" + originalFilename;
                System.out.println("storedFileName =" + storedFileName);
                //저장을 위한 BoardFileDTO 세팅
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setOriginalFileName(originalFilename);
                boardFileDTO.setStoredFileName(storedFileName);
                boardFileDTO.setBoardId(dto.getId());
                // 매개변수 DTO가 아닌 리턴받은 dto를 사용해야함
                //로컬에 파일 저장
                // 저장할 경로 설정(저장할폴더 + 저장할이름)
//                String savePath = "C:\\Users\\LEE HOSEOP\\Desktop\\DATE\\Spring\\board\\springframework_img\\" + storedFileName;
                // 학원 경로
                String savePath = "D:\\springframework_img\\" + storedFileName;
                // 저장처리
                boardFile.transferTo(new File(savePath)); // new File()은 자바에서 제공하는 클래스
                boardRepository.saveFile(boardFileDTO);
            }
        }

    }

    public List<BoardDTO> BoardList() {
        return boardRepository.BoardList();
    }

    public BoardDTO boardDetail(Long id) {
        return boardRepository.boardDetail(id);
    }

    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }


    public List<BoardDTO> searchTitle(BoardDTO boardDTO) {
        return boardRepository.searchTitle(boardDTO);
    }

    public List<BoardDTO> searchWriter(BoardDTO boardDTO) {
        return boardRepository.searchWriter(boardDTO);
    }

    public List<BoardDTO> searchContents(BoardDTO boardDTO) {
        return boardRepository.searchContents(boardDTO);
    }

    public void updateHits(Long id) {
        boardRepository.updateHits(id);
    }

    public List<BoardFileDTO> findFile(Long id) {
        return boardRepository.findFile(id);
    }

    public List<BoardDTO> pagingList(int page) {
        int pageLimit = 9; // 한페이지에 보여줄 글 갯수
        int pageStart = (page-1) * pageLimit;
        Map<String,Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pageStart);
        pagingParams.put("limit",pageLimit);
        List<BoardDTO> boardDTOList = boardRepository.pagingList(pagingParams);
        return boardDTOList;
    }

    public PageDTO pagingParam(int page) {
        int pageLimit = 9; // 현페이지에 보여줄 글 갯수
        int blockLimit = 3; //하단에 보여줄 페이지 번호 갯수
        // 전체 글 갯수 조회
        int boardCount = boardRepository.boardCount();
        // 전체 페이지 갯수 계산
        int maxPage = (int)(Math.ceil((double)boardCount / pageLimit));
        // 시작 페이지 값 계산(1,4,7,10~~)
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 마지막 페이지 값 계산(3.6.9.12~~)
        int endPage = startPage + blockLimit - 1 ;
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 대는 endPage 값을 maxPage와 같게 세팅
        if(endPage > maxPage){
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        return pageDTO;
    }
}
