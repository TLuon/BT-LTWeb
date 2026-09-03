package vn.iotstar.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Product;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.utils.Constants;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert",
        "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
public class ProductAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("listpro", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/add")) {
            List<Category> listcate = categoryService.findAll();
            req.setAttribute("listcate", listcate);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> listcate = categoryService.findAll();
            req.setAttribute("pro", product);
            req.setAttribute("listcate", listcate);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/product/insert")) {
            String productname = req.getParameter("productname");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            int stock = Integer.parseInt(req.getParameter("stock"));
            int status = Integer.parseInt(req.getParameter("status"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            Product product = new Product();
            product.setProductName(productname);
            product.setDescription(description);
            product.setPrice(price);
            product.setStock(stock);
            product.setStatus(status);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            String fname = "";
            String uploadPath = Constants.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    product.setImages(fname);
                } else {
                    product.setImages("default_product.png");
                }
            } catch (Exception e) { e.printStackTrace(); }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }

        if (url.contains("/admin/product/update")) {
            int productid = Integer.parseInt(req.getParameter("productid"));
            String productname = req.getParameter("productname");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            int stock = Integer.parseInt(req.getParameter("stock"));
            int status = Integer.parseInt(req.getParameter("status"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            Product product = productService.findById(productid);
            product.setProductName(productname);
            product.setDescription(description);
            product.setPrice(price);
            product.setStock(stock);
            product.setStatus(status);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            String fileold = product.getImages();
            String fname = "";
            String uploadPath = Constants.DIR;

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    if (fileold != null && !fileold.isEmpty()) {
                        Path path = Paths.get(uploadPath + "\\" + fileold);
                        Files.deleteIfExists(path);
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    product.setImages(fname);
                }
            } catch (Exception e) { e.printStackTrace(); }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}
