package vn.iotstar.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.iotstar.model.Category;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public void insert(Category category) {
        categoryRepository.save(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryRepository.findById(newCategory.getId())
                .orElseThrow(() -> new RuntimeException("Category not found: " + newCategory.getId()));
        oldCategory.setName(newCategory.getName());
        // Chỉ cập nhật icon nếu có icon mới (giữ ảnh cũ nếu không upload lại)
        if (newCategory.getIcon() != null && !newCategory.getIcon().isEmpty()) {
            oldCategory.setIcon(newCategory.getIcon());
        }
        categoryRepository.save(oldCategory);
    }

    @Override
    public void delete(int id) {
        categoryRepository.deleteById(id);
    }

    @Override
    public Category get(int id) {
        return categoryRepository.findById(id).orElse(null);
    }

    @Override
    public Category get(String name) {
        return categoryRepository.findByName(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryRepository.findAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryRepository.findByNameContaining(keyword);
    }
}
