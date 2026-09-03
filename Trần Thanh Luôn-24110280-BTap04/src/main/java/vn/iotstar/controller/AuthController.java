package vn.iotstar.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.utils.EmailUtil;

@WebServlet(urlPatterns = { "/login", "/register", "/verify", "/forgot", "/reset", "/logout" })
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/login")) {
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        } else if (url.contains("/register")) {
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        } else if (url.contains("/verify")) {
            req.getRequestDispatcher("/views/auth/verify.jsp").forward(req, resp);
        } else if (url.contains("/forgot")) {
            req.getRequestDispatcher("/views/auth/forgot.jsp").forward(req, resp);
        } else if (url.contains("/reset")) {
            req.getRequestDispatcher("/views/auth/reset.jsp").forward(req, resp);
        } else if (url.contains("/logout")) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/login")) {
            postLogin(req, resp);
        } else if (url.contains("/register")) {
            postRegister(req, resp);
        } else if (url.contains("/verify")) {
            postVerify(req, resp);
        } else if (url.contains("/forgot")) {
            postForgot(req, resp);
        } else if (url.contains("/reset")) {
            postReset(req, resp);
        }
    }

    private void postLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User user = userService.findByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            if (user.getStatus() == 0) {
                req.setAttribute("error", "Tài khoản chưa được kích hoạt OTP.");
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
                return;
            }
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng.");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }

    private void postRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");

        if (userService.findByEmail(email) != null) {
            req.setAttribute("error", "Email đã tồn tại.");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        String otp = String.valueOf(new Random().nextInt(900000) + 100000);
        
        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setRole(0); // user
        user.setStatus(0); // inactive
        user.setOtpCode(otp);
        user.setOtpExpiry(new Date(System.currentTimeMillis() + 10 * 60 * 1000)); // 10 minutes

        userService.insert(user);
        
        // Send OTP
        boolean isSent = EmailUtil.sendEmail(email, "Mã xác thực OTP đăng ký", "Mã OTP của bạn là: " + otp + ". Mã có hiệu lực trong 10 phút.");
        if (!isSent) {
            System.out.println("LỖI GỬI EMAIL! Mã OTP đăng ký cho " + email + " là: " + otp);
        } else {
            System.out.println("Đã gửi email OTP tới: " + email);
        }

        req.getSession().setAttribute("verify_email", email);
        resp.sendRedirect(req.getContextPath() + "/verify");
    }

    private void postVerify(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = (String) req.getSession().getAttribute("verify_email");
        if(email == null) email = req.getParameter("email");
        
        String otp = req.getParameter("otp");
        User user = userService.findByEmail(email);

        if (user != null && user.getOtpCode().equals(otp)) {
            if (user.getOtpExpiry().before(new Date())) {
                req.setAttribute("error", "Mã OTP đã hết hạn.");
                req.getRequestDispatcher("/views/auth/verify.jsp").forward(req, resp);
            } else {
                user.setStatus(1); // active
                user.setOtpCode(null);
                user.setOtpExpiry(null);
                userService.update(user);
                resp.sendRedirect(req.getContextPath() + "/login?msg=active_success");
            }
        } else {
            req.setAttribute("error", "Mã OTP không đúng.");
            req.getRequestDispatcher("/views/auth/verify.jsp").forward(req, resp);
        }
    }

    private void postForgot(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        User user = userService.findByEmail(email);

        if (user != null) {
            String otp = String.valueOf(new Random().nextInt(900000) + 100000);
            user.setOtpCode(otp);
            user.setOtpExpiry(new Date(System.currentTimeMillis() + 10 * 60 * 1000));
            userService.update(user);

            boolean isSent = EmailUtil.sendEmail(email, "Mã xác thực Đặt lại mật khẩu", "Mã OTP của bạn là: " + otp);
            if (!isSent) {
                System.out.println("LỖI GỬI EMAIL! Mã OTP reset pass cho " + email + " là: " + otp);
            } else {
                System.out.println("Đã gửi email OTP tới: " + email);
            }
            req.getSession().setAttribute("reset_email", email);
            resp.sendRedirect(req.getContextPath() + "/reset");
        } else {
            req.setAttribute("error", "Email không tồn tại.");
            req.getRequestDispatcher("/views/auth/forgot.jsp").forward(req, resp);
        }
    }

    private void postReset(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = (String) req.getSession().getAttribute("reset_email");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("password");
        
        User user = userService.findByEmail(email);
        if (user != null && user.getOtpCode().equals(otp)) {
            if (user.getOtpExpiry().before(new Date())) {
                req.setAttribute("error", "Mã OTP đã hết hạn.");
                req.getRequestDispatcher("/views/auth/reset.jsp").forward(req, resp);
            } else {
                user.setPassword(newPassword);
                user.setOtpCode(null);
                user.setOtpExpiry(null);
                userService.update(user);
                resp.sendRedirect(req.getContextPath() + "/login?msg=reset_success");
            }
        } else {
            req.setAttribute("error", "Mã OTP không đúng.");
            req.getRequestDispatcher("/views/auth/reset.jsp").forward(req, resp);
        }
    }
}
