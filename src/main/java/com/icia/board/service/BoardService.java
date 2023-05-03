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
}
