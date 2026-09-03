# ShoppingServiceMVC — Spring Boot version

Chuyển đổi từ 2 bài Servlet/JDBC gốc:
- `14_HD_Servlet_JDBC_CRUD.pdf` (CRUD Category)
- `06_MVC_3tier.pdf` (Login / Register theo MVC2)

sang **Spring Boot + Spring Data JPA + Thymeleaf**, vẫn giữ đúng kiến trúc
3 tầng: **Controller → Service → Repository (DAO)**.

## Cách chạy trong Spring Tool Suite (STS)

1. Giải nén thư mục `shopping-mvc/`.
2. Trong STS: `File > Import > Existing Maven Projects` → chọn thư mục `shopping-mvc`.
3. Đợi Maven tải dependencies xong (xem tiến trình ở góc dưới phải).
4. Mở `src/main/resources/application.properties`, sửa lại:
   - `spring.datasource.url` (tên database của bạn)
   - `spring.datasource.username` / `password`
   - `file.upload-dir` (thư mục lưu ảnh, ví dụ `E:/upload` hoặc `/home/user/upload`)
5. Đảm bảo SQL Server (hoặc MySQL) đang chạy, đã tạo sẵn database `ShoppingServiceMVC`.
   - Không cần tự tạo bảng `Category` / `User` — vì `spring.jpa.hibernate.ddl-auto=update`
     nên Hibernate sẽ tự tạo bảng dựa theo Entity khi chạy lần đầu.
6. Click phải vào project → `Run As > Spring Boot App`.
7. Mở trình duyệt:
   - Đăng nhập: `http://localhost:8080/login`
   - Đăng ký: `http://localhost:8080/register`
   - Quản lý danh mục: `http://localhost:8080/admin/category/list`

## Nếu dùng MySQL thay vì SQL Server

Trong `pom.xml`, đổi dependency:
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
```

Trong `application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/ShoppingServiceMVC?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=your_password
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

## Cấu trúc thư mục chính

```
vn.iotstar
 ├─ model/              Category.java, User.java        (Entity - JPA)
 ├─ repository/         CategoryRepository, UserRepository (thay DAO)
 ├─ service/            interface
 ├─ service/impl/       cài đặt logic (business layer)
 ├─ controller/         CategoryController, AuthController
 ├─ config/             WebConfig (serve ảnh upload qua /image/**)
 └─ util/               FileStorageUtil (lưu file upload)

resources/templates/    file .html Thymeleaf (thay cho .jsp)
```

## Đối chiếu với bản Servlet gốc

| Servlet gốc                     | Spring Boot                              |
|----------------------------------|-------------------------------------------|
| `CategoryDaoImpl` (JDBC thủ công) | `CategoryRepository extends JpaRepository` |
| `CategoryServiceImpl`            | `CategoryServiceImpl` (giữ nguyên vai trò) |
| 4 Servlet List/Add/Edit/Delete   | 1 `CategoryController` với `@GetMapping`/`@PostMapping` |
| `LoginController`, `RegisterController`, `WaitingController` | gộp vào `AuthController` |
| `DownloadImageController`       | `WebConfig` (resource handler `/image/**`) |
| `.jsp` + JSTL (`c:forEach`, `c:if`) | `.html` + Thymeleaf (`th:each`, `th:if`) |
| `HttpSession`, `Cookie`         | Giữ nguyên, dùng y hệt API servlet trong Spring MVC |

## Ghi video nộp bài

Khi quay video, nên demo và giải thích:
1. Chạy ứng dụng, đăng ký tài khoản mới → đăng nhập.
2. Vào `/admin/category/list`, thêm/sửa/xóa danh mục kèm ảnh.
3. Mở code chỉ ra luồng Controller → Service → Repository tương ứng
   với luồng Controller → Service → DAO trong bản Servlet gốc.
