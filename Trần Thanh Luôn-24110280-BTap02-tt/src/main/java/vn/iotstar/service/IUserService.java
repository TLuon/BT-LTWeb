package vn.iotstar.service;
import vn.iotstar.entity.User;
public interface IUserService {
    void insert(User user);
    void update(User user);
    User findByEmail(String email);
    User findByUsername(String username);
}
