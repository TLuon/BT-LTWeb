package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/home", "/product", "/product/detail" })
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        
        if (url.endsWith("/home") || url.equals(req.getContextPath() + "/")) {
            // Lấy 10 sản phẩm mới nhất
            List<Product> top10 = productService.findTop(10);
            req.setAttribute("topProducts", top10);
            req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
        } else if (url.contains("/product/detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            req.setAttribute("product", product);
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
        } else if (url.contains("/product")) {
            // Phân trang
            int page = 0;
            int pagesize = 6;
            if(req.getParameter("page") != null) {
                page = Integer.parseInt(req.getParameter("page")) - 1; // page start from 0
            }
            if(page < 0) page = 0;
            
            List<Product> list = productService.findAll(page, pagesize);
            int total = productService.count();
            int totalPage = (int) Math.ceil((double) total / pagesize);

            req.setAttribute("listProducts", list);
            req.setAttribute("currentPage", page + 1);
            req.setAttribute("totalPage", totalPage);
            req.getRequestDispatcher("/views/web/product.jsp").forward(req, resp);
        }
    }
}
