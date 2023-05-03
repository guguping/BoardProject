package com.icia.board.repository;

import com.icia.board.dto.BoardDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public void BoardSave(BoardDTO boardDTO) {
        sql.insert("Board.Save",boardDTO);
    }

    public List<BoardDTO> BoardList() {
        return sql.selectList("Board.List");
    }
}
