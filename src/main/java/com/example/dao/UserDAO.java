package com.example.dao;

import com.example.model.User;

public class UserDAO {
    
    // Tầng DAO giao tiếp với cơ sở dữ liệu (ở đây mock cứng dữ liệu cho bài tập)
    public boolean isValidUser(String username, String password) {
        // Cho phép đăng nhập với admin/admin
        return "admin".equals(username) && "admin".equals(password);
    }
}
