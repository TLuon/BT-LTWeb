package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;

/**
 * Gom LoginController + RegisterController + WaitingController (slide
 * 06_MVC_3tier) thanh 1 Controller theo Spring MVC.
 */
@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    private static final String COOKIE_REMEMBER = "username";

    // ================== LOGIN ==================

    // Buoc 7 (slide 15): GET /login
    @GetMapping("/login")
    public String loginForm(HttpServletRequest req, HttpSession session) {
        if (session.getAttribute("account") != null) {
            return "redirect:/waiting";
        }
        // Check cookie "remember me"
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(COOKIE_REMEMBER)) {
                    User u = userService.get(cookie.getValue());
                    if (u != null) {
                        session.setAttribute("account", u);
                        return "redirect:/waiting";
                    }
                }
            }
        }
        return "login";
    }

    // Buoc 7 (slide 16-17): POST /login
    @PostMapping("/login")
    public String login(@RequestParam String username,
                         @RequestParam String password,
                         @RequestParam(required = false) String remember,
                         HttpSession session,
                         HttpServletResponse resp,
                         Model model) {

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            model.addAttribute("alert", "Tài khoản hoặc mật khẩu không được rỗng");
            return "login";
        }

        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("account", user);
            if ("on".equals(remember)) {
                saveRememberMe(resp, username);
            }
            return "redirect:/waiting";
        } else {
            model.addAttribute("alert", "Tài khoản hoặc mật khẩu không đúng");
            return "login";
        }
    }

    private void saveRememberMe(HttpServletResponse response, String username) {
        Cookie cookie = new Cookie(COOKIE_REMEMBER, username);
        cookie.setMaxAge(30 * 60);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    // ================== REGISTER ==================

    // Buoc 7 (slide 30): GET /register
    @GetMapping("/register")
    public String registerForm(HttpSession session) {
        if (session.getAttribute("account") != null) {
            return "redirect:/waiting";
        }
        return "register";
    }

    // Buoc 7 (slide 32-34): POST /register
    @PostMapping("/register")
    public String register(@RequestParam String username,
                            @RequestParam String password,
                            @RequestParam String email,
                            @RequestParam String fullname,
                            @RequestParam String phone,
                            Model model) {

        if (userService.checkExistEmail(email)) {
            model.addAttribute("alert", "Email đã tồn tại!");
            return "register";
        }
        if (userService.checkExistUsername(username)) {
            model.addAttribute("alert", "Tài khoản đã tồn tại!");
            return "register";
        }

        boolean isSuccess = userService.register(username, password, email, fullname, phone);
        if (isSuccess) {
            return "redirect:/login";
        } else {
            model.addAttribute("alert", "System error!");
            return "register";
        }
    }

    // ================== WAITING (dieu huong theo role) ==================

    // Buoc 9 (slide 19): GET /waiting
    @GetMapping("/waiting")
    public String waiting(HttpSession session) {
        User u = (User) session.getAttribute("account");
        if (u == null) {
            return "redirect:/login";
        }
        if (u.getRoleid() == 1) {
            return "redirect:/admin/category/list"; // admin -> trang quan ly
        } else if (u.getRoleid() == 2) {
            return "redirect:/manager/home";
        } else {
            return "redirect:/home";
        }
    }

    // ================== LOGOUT ==================

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // Trang chu tam thoi cho user thuong
    @GetMapping("/home")
    public String home() {
        return "home";
    }
}
