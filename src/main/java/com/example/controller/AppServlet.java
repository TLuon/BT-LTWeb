package com.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.service.AuthService;
import java.io.IOException;

@WebServlet(urlPatterns = {"/", "/home", "/login", "/error"})
public class AppServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        // Khởi tạo các component của kiến trúc 3 tầng
        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.equals("/login")) {
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        } else if (path.equals("/error")) {
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        } else {
            // Mặc định là trang chủ cho "/", "/home"
            request.getRequestDispatcher("/views/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.equals("/login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Sử dụng tầng Service để xử lý logic xác thực
            boolean isValid = authService.authenticate(username, password);

            if (isValid) {
                // Đăng nhập thành công -> chuyển hướng về /home
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                // Đăng nhập sai -> chuyển hướng về /error
                response.sendRedirect(request.getContextPath() + "/error");
            }
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
}
