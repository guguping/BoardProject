package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.dto.CommentDTO;
import com.icia.board.dto.PageDTO;
import com.icia.board.service.BoardService;
import com.icia.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board") // 공통 주소값으로 설정
public class BoardController {
    @Autowired
    private BoardService boardService;
    @Autowired
    private CommentService commentService;

    @GetMapping("/save") // /board/save
    public String BoardSave() {
        return "boardPages/boardSave";
    }

    @PostMapping("/save") // /board/save
    public String BoardSave(@ModelAttribute BoardDTO boardDTO) throws IOException {
        System.out.println("boardDTO = " + boardDTO);
        boardService.BoardSave(boardDTO);
        return "redirect:/board/";
    }

    @GetMapping("/") // /bard/
    public String BoardList(Model model) {
        model.addAttribute("bList", boardService.BoardList());
        return "boardPages/boardList";
    }

    @GetMapping
    public String boardDetail(@RequestParam("id") Long id, Model model, HttpSession session) {
        boardService.updateHits(id);
        BoardDTO boardDTO = boardService.boardDetail(id);
        if (boardDTO.getFileAttached() == 1) {
            List<BoardFileDTO> boardFileList = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileList);
            System.out.println("boardFileDTO = " + boardFileList);
        }
        List<CommentDTO> cList = commentService.boardComment(id);
        if (cList.size() == 0) {
            model.addAttribute("cList", null);
        } else {
            model.addAttribute("cList", cList);
        }
        model.addAttribute("boardDTO", boardDTO);
        return "boardPages/boardDetail";
    }

    @GetMapping("/update")
    public String boardUpdate(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.boardDetail(id);
        model.addAttribute("boardDTO", boardDTO);
        return "boardPages/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO, Model model) {
        boardService.update(boardDTO);
        BoardDTO dto = boardService.boardDetail(boardDTO.getId());
        model.addAttribute("boardDTO", dto);
        return "boardPages/boardDetail";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.boardDetail(id);
        model.addAttribute("boardDTO", boardDTO);
        return "boardPages/boardDelete";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        boardService.delete(id);
        return "redirect:/board/";
    }

    @GetMapping("/searchList")
    public String search(@RequestParam("Title") String Title,
                         @RequestParam("Writer") String Writer,
                         @RequestParam("Contents") String Contents,
                         Model model) {
        BoardDTO boardDTO = new BoardDTO();
        System.out.println("Title = " + Title + ", Writer = " + Writer + ", Contents = " + Contents);
        if (Writer.equals("boardWriter") && Contents.equals("boardContents")) {
            boardDTO.setBoardTitle(Title);
            List<BoardDTO> bList = boardService.searchTitle(boardDTO);
            model.addAttribute("bList", bList);
        } else if (Title.equals("boardTitle") && Contents.equals("boardContents")) {
            boardDTO.setBoardWriter(Writer);
            List<BoardDTO> bList = boardService.searchWriter(boardDTO);
            model.addAttribute("bList", bList);
        } else {
            boardDTO.setBoardContents(Contents);
            List<BoardDTO> bList = boardService.searchContents(boardDTO);
            model.addAttribute("bList", bList);
        }
        System.out.println(boardDTO);
        return "boardPages/boardList";
    }
//    @GetMapping("/paging")
//    public String paging(@RequestParam(value = "page", required = false, defaultValue = "1" ) int page,
//                         Model model){
//        System.out.println("page = " + page);
//        // 사용자가 요청한 페이지에 해당하는 글 목록 데이터
//        List<BoardDTO> boardDTOList = boardService.pagingList(page);
//        System.out.println("boardDTOList = " + boardDTOList);
//        //하단에 보여줄 페이지 번호 목록데이터
//        PageDTO pageDTO = boardService.pagingParam(page);
//        model.addAttribute("boardList",boardDTOList);
//        model.addAttribute("paging",pageDTO);
//        return "boardPages/boardPaging";
//    }


    // pagin Mapping과 search Mapping을 합친것
    @GetMapping("/paging")
    public String paging(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         @RequestParam(value = "q", required = false, defaultValue = "") String q,
                         @RequestParam(value = "type", required = false, defaultValue = "") String type,
                         Model model) {
        System.out.println("page = " + page + ", q = " + q);
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;
        if (q.equals("")) { // 검색어가 없다면 기본 페이징처리
            // 사용자가 요청한 페이지에 해당하는 글 목록 데이터
            boardDTOList = boardService.pagingList(page);
            // 하단에 보여줄 페이지 번호 목록 데이터
            pageDTO = boardService.pagingParam(page);
        } else {// 있다면 검색어 페이징 처리
            boardDTOList = boardService.searchList(page, type, q);
            pageDTO = boardService.pagingSearchParam(page, type, q);
        }
        model.addAttribute("boardList", boardDTOList);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        return "boardPages/boardPaging";
    }

//    @GetMapping("/search")
//    public String search(@RequestParam("q") String q,
//                         @RequestParam(value = "page", required = false, defaultValue = "1") int page,
//                         Model model) {
//        List<BoardDTO> boardDTOList = boardService.searchList(q, page);
//        PageDTO pageDTO = boardService.pagingSearchParam(page, q);
//        model.addAttribute("boardList", boardDTOList);
//        model.addAttribute("paging", pageDTO);
//        model.addAttribute("q",q);
//        return "boardPages/boardPaging";
//    }
}
