package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int productId) throws Exception;
    Product findById(int productId);
    List<Product> findAll();
    List<Product> findAll(int page, int pagesize);
    List<Product> findTop(int limit);
    int count();
}
