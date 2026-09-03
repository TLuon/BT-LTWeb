package vn.iotstar.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.util.FileStorageUtil;

/**
 * Gom 4 servlet cua ban goc (List/Add/Edit/Delete) vao 1 Controller duy nhat,
 * dung theo tinh than mo hinh MVC2 trong slide 06_MVC_3tier.
 */
@Controller
@RequestMapping("/admin/category")
public class CategoryController {

    @Autowired
    private CategoryService cateService;

    @Value("${file.upload-dir}")
    private String uploadDir;

    // Buoc 9 (slide 22): GET /admin/category/list
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("cateList", cateService.getAll());
        return "admin/list-category";
    }

    // Buoc 9 (slide 26): GET /admin/category/add
    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("category", new Category());
        return "admin/add-category";
    }

    // POST /admin/category/add
    @PostMapping("/add")
    public String add(@RequestParam String name,
                       @RequestParam(value = "icon", required = false) MultipartFile icon) throws IOException {
        Category category = new Category();
        category.setName(name);
        if (icon != null && !icon.isEmpty()) {
            category.setIcon(FileStorageUtil.save(icon, uploadDir, "category"));
        }
        cateService.insert(category);
        return "redirect:/admin/category/list";
    }

    // Buoc 9 (slide 23): GET /admin/category/edit?id=
    @GetMapping("/edit")
    public String editForm(@RequestParam int id, Model model) {
        model.addAttribute("category", cateService.get(id));
        return "admin/edit-category";
    }

    // POST /admin/category/edit
    @PostMapping("/edit")
    public String edit(@RequestParam int id,
                        @RequestParam String name,
                        @RequestParam(value = "icon", required = false) MultipartFile icon) throws IOException {
        Category category = new Category();
        category.setId(id);
        category.setName(name);
        if (icon != null && !icon.isEmpty()) {
            category.setIcon(FileStorageUtil.save(icon, uploadDir, "category"));
        }
        cateService.edit(category);
        return "redirect:/admin/category/list";
    }

    // Buoc 9 (slide 29): GET /admin/category/delete?id=
    @GetMapping("/delete")
    public String delete(@RequestParam int id) {
        cateService.delete(id);
        return "redirect:/admin/category/list";
    }
}
