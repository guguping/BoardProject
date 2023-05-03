package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/board/save")
    public String BoardSave(){
        return "boardPages/boardSave";
    }

    @PostMapping("/board/save")
    public String BoardSave(@ModelAttribute BoardDTO boardDTO){
        boardService.BoardSave(boardDTO);
        return "redirect:/board/";
    }

    @GetMapping("/board/")
    public String BoardList(Model model){
        model.addAttribute("bList",boardService.BoardList());
        return "boardPages/boardList";
    }
}
