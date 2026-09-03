package vn.iotstar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.iotstar.model.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {

    List<Category> findByNameContaining(String keyword);

    Category findByName(String name);
}
