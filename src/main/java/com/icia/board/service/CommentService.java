package com.icia.board.service;

import com.icia.board.dto.CommentDTO;
import com.icia.board.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public List<CommentDTO> boardComment(Long id) {
        return commentRepository.boardComment(id);
    }

    public void save(CommentDTO commentDTO) {
        commentRepository.save(commentDTO);
    }
}
