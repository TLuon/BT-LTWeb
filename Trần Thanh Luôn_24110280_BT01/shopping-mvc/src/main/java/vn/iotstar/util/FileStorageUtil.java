package vn.iotstar.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.web.multipart.MultipartFile;

public class FileStorageUtil {

    /**
     * Luu file upload vao {uploadDir}/{subFolder}/{ten-file-random}
     * Tra ve duong dan tuong doi (vi du: "category/1723456.png") de luu vao DB
     * va dung chung voi url "/image/{duong-dan}".
     */
    public static String save(MultipartFile file, String uploadDir, String subFolder) throws IOException {
        String original = file.getOriginalFilename();
        String ext = "";
        if (original != null && original.contains(".")) {
            ext = original.substring(original.lastIndexOf("."));
        }
        String fileName = System.currentTimeMillis() + ext;

        Path folder = Paths.get(uploadDir, subFolder);
        Files.createDirectories(folder);

        Path target = folder.resolve(fileName);
        file.transferTo(target);

        return subFolder + "/" + fileName;
    }
}
