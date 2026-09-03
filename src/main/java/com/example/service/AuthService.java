package com.example.service;

import com.example.dao.UserDAO;

public class AuthService {
    private UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    public boolean authenticate(String username, String password) {
        // Tầng Service gọi tầng DAO để kiểm tra dữ liệu
        return userDAO.isValidUser(username, password);
    }
}
