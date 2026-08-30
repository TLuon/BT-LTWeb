package vn.iotstar.service.impl;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;

public class UserServiceImpl implements IUserService {
    IUserDao userDao = new UserDao();
    @Override public void insert(User user) { userDao.insert(user); }
    @Override public void update(User user) { userDao.update(user); }
    @Override public User findByEmail(String email) { return userDao.findByEmail(email); }
    @Override public User findByUsername(String username) { return userDao.findByUsername(username); }
}
