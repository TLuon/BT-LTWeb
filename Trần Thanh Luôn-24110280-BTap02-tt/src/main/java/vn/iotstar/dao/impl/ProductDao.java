package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDao implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int productId) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Product product = enma.find(Product.class, productId);
            if (product != null) {
                enma.remove(product);
            } else {
                throw new Exception("Không tìm thấy");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Product findById(int productId) {
        EntityManager enma = JpaConfig.getEntityManager();
        Product product = enma.find(Product.class, productId);
        return product;
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
        return query.getResultList();
    }

    @Override
    public List<Product> findAll(int page, int pagesize) {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
        query.setFirstResult(page * pagesize);
        query.setMaxResults(pagesize);
        return query.getResultList();
    }

    @Override
    public List<Product> findTop(int limit) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p ORDER BY p.productId DESC", Product.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT count(p) FROM Product p";
        Query query = enma.createQuery(jpql);
        return ((Long) query.getSingleResult()).intValue();
    }
}
