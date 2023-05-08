package com.icia.board.repository;

import com.icia.board.dto.CommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class CommentRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public List<CommentDTO> boardComment(Long id) {
        return sql.selectList("Board.boardComment",id);
    }

    public void save(CommentDTO commentDTO) {
        sql.insert("Board.commentSave",commentDTO);
    }
}
