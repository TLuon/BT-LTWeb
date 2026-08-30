package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
    void insert(User user);
    void update(User user);
    User findByEmail(String email);
    User findByUsername(String username);
}
