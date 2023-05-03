package com.icia.board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class BoardDTO {
    Long id;
    String boardWriter;
    String boardPass;
    String boardTitle;
    String boardContents;
    Timestamp boardCreateDate;
    int boardHits = 0;
}
