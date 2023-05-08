package com.icia.board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class CommentDTO {
    Long id;
    String commentWriter;
    String commentContents;
    Long boardId;
    Timestamp commentCreatedDate;
}
