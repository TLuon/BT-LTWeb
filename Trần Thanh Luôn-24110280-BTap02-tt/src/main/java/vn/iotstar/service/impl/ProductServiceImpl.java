package vn.iotstar.service.impl;
import java.util.List;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDao;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;

public class ProductServiceImpl implements IProductService {
    IProductDao productDao = new ProductDao();
    @Override public void insert(Product product) { productDao.insert(product); }
    @Override public void update(Product product) { productDao.update(product); }
    @Override public void delete(int productId) throws Exception { productDao.delete(productId); }
    @Override public Product findById(int productId) { return productDao.findById(productId); }
    @Override public List<Product> findAll() { return productDao.findAll(); }
    @Override public List<Product> findAll(int page, int pagesize) { return productDao.findAll(page, pagesize); }
    @Override public List<Product> findTop(int limit) { return productDao.findTop(limit); }
    @Override public int count() { return productDao.count(); }
}
