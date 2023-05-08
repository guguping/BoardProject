package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.dto.CommentDTO;
import com.icia.board.service.BoardService;
import com.icia.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    public String BoardSave(){
        return "boardPages/boardSave";
    }

    @PostMapping("/save") // /board/save
    public String BoardSave(@ModelAttribute BoardDTO boardDTO) throws IOException {
        System.out.println("boardDTO = " + boardDTO);
        boardService.BoardSave(boardDTO);
        return "redirect:/board/";
    }

    @GetMapping("/") // /bard/
    public String BoardList(Model model){
        model.addAttribute("bList",boardService.BoardList());
        return "boardPages/boardList";
    }
    @GetMapping
    public String boardDetail(@RequestParam("id") Long id , Model model){
        boardService.updateHits(id);
        BoardDTO boardDTO = boardService.boardDetail(id);
        if(boardDTO.getFileAttached() == 1){
            List<BoardFileDTO> boardFileList = boardService.findFile(id);
            model.addAttribute("boardFileList",boardFileList);
            System.out.println("boardFileDTO = " + boardFileList);
        }
        List<CommentDTO> cList = commentService.boardComment(id);
        if(cList.size()==0){
            model.addAttribute("cList",null);
        }else{
            model.addAttribute("cList",cList);
        }
        model.addAttribute("boardDTO",boardDTO);
        return "boardPages/boardDetail";
    }
    @GetMapping("/update")
    public String boardUpdate(@RequestParam("id") Long id , Model model){
        BoardDTO boardDTO = boardService.boardDetail(id);
        model.addAttribute("boardDTO",boardDTO);
        return "boardPages/boardUpdate";
    }
    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO,Model model){
        boardService.update(boardDTO);
        BoardDTO dto = boardService.boardDetail(boardDTO.getId());
        model.addAttribute("boardDTO",dto);
        return "boardPages/boardDetail";
    }
    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id , Model model){
        BoardDTO boardDTO = boardService.boardDetail(id);
        model.addAttribute("boardDTO",boardDTO);
        return "boardPages/boardDelete";
    }
    @PostMapping("/delete")
    public String delete(@RequestParam("id") Long id){
        boardService.delete(id);
        return "redirect:/board/";
    }
    @GetMapping("/searchList")
    public String search(@RequestParam("Title") String Title ,
                       @RequestParam("Writer") String Writer ,
                       @RequestParam("Contents") String Contents,
                         Model model){
        BoardDTO boardDTO = new BoardDTO();
        System.out.println("Title = " + Title + ", Writer = " + Writer + ", Contents = " + Contents);
        if(Writer.equals("boardWriter")&&Contents.equals("boardContents")){
            boardDTO.setBoardTitle(Title);
            List<BoardDTO> bList = boardService.searchTitle(boardDTO);
            model.addAttribute("bList",bList);
        }else if(Title.equals("boardTitle")&&Contents.equals("boardContents")){
            boardDTO.setBoardWriter(Writer);
            List<BoardDTO> bList = boardService.searchWriter(boardDTO);
            model.addAttribute("bList",bList);
        }else{
            boardDTO.setBoardContents(Contents);
            List<BoardDTO> bList = boardService.searchContents(boardDTO);
            model.addAttribute("bList",bList);
        }
        System.out.println(boardDTO);
        return "boardPages/boardList";
    }
}
