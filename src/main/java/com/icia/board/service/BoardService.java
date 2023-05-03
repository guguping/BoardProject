package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;
    public void BoardSave(BoardDTO boardDTO) {
        boardRepository.BoardSave(boardDTO);
    }

    public List<BoardDTO> BoardList() {
        return boardRepository.BoardList();
    }
}
