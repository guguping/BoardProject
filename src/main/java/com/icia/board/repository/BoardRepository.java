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

    public BoardDTO boardDetail(Long id) {
        return sql.selectOne("Board.Detail",id);
    }

    public void update(BoardDTO boardDTO) {
        sql.update("Board.update",boardDTO);
    }

    public void delete(Long id) {
        sql.delete("Board.delete",id);
    }

    public List<BoardDTO> searchTitle(BoardDTO boardDTO) {
        return sql.selectList("Board.searchTitle",boardDTO);
    }

    public List<BoardDTO> searchWriter(BoardDTO boardDTO) {
        return sql.selectList("Board.searchWriter",boardDTO);
    }

    public List<BoardDTO> searchContents(BoardDTO boardDTO) {
        return sql.selectList("Board.searchContents",boardDTO);
    }

    public void updateHits(Long id) {
        sql.update("Board.updateHits",id);
    }
}
