package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.utils.Constants;

@MultipartConfig
@WebServlet(urlPatterns = { "/user/profile" })
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");
        
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Fetch fresh user data
        User user = userService.findByEmail(currentUser.getEmail());
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");
        
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Basic validation
        if (fullname == null || fullname.trim().isEmpty()) {
            req.setAttribute("error", "Fullname is required.");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
            return;
        }

        User user = userService.findByEmail(currentUser.getEmail());
        user.setFullname(fullname);
        user.setPhone(phone);

        // Handle image upload
        String uploadPath = Constants.DIR; 
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                if (index > 0) {
                    String ext = filename.substring(index + 1);
                    String fname = "user_" + System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    user.setImages(fname);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        userService.update(user);
        session.setAttribute("account", user);
        
        req.setAttribute("message", "Profile updated successfully!");
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }
}
