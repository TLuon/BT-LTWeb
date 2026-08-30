package vn.iotstar.entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="categories")
@NamedQuery(name="Category.findAll", query="SELECT c FROM Category c")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="categoryId")
    private int categoryId;

    @Column(name="categoryname", columnDefinition ="NVARCHAR(255) NULL")
    private String categoryname;

    @Column(name="images", columnDefinition ="NVARCHAR(255) NULL")
    private String images;

    @Column(name="status")
    private int status;

    // bi-directional many-to-one association to Video
    @OneToMany(mappedBy="categories")
    private List<Video> videos;

    // bi-directional many-to-one association to Product
    @OneToMany(mappedBy="category")
    private List<Product> products;

    public Category() {
    }

    public int getCategoryId() {
        return this.categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<Video> getVideos() {
        return this.videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public Video addVideo(Video video) {
        getVideos().add(video);
        video.setCategory(this);
        return video;
    }

    public Video removeVideo(Video video) {
        getVideos().remove(video);
        video.setCategory(null);
        return video;
    }

    public List<Product> getProducts() {
        return this.products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public Product addProduct(Product product) {
        getProducts().add(product);
        product.setCategory(this);
        return product;
    }

    public Product removeProduct(Product product) {
        getProducts().remove(product);
        product.setCategory(null);
        return product;
    }
}
