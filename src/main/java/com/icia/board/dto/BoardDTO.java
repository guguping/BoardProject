package com.icia.board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;

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
    int fileAttached = 0;
    List<MultipartFile> boardFile;
}
