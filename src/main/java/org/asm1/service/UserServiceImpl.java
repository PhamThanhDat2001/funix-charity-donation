package org.asm1.service;

import org.asm1.dao.UserDao;
import org.asm1.entity.User;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    @Transactional
    public User findByEmailAndPassword(String email, String password) {
        return userDao.findByEmailAndPassword(email, password);
    }

    @Override
    @Transactional
    public List<User> getUser() {
        return userDao.getUser();
    }
    // Autowire JdbcTemplate để truy vấn cơ sở dữ liệu

    @Override
    @Transactional
    public void deleteUser(int id) {
        userDao.deleteUser(id);
    }

    @Override
    @Transactional
    public User getUserById(int id) {
        return userDao.getUserById(id);
    }

    public List<User> getUser(int page, int size) {

        return userDao.getUser(page,size);
    }

    public long getTotalUsers() {

        return userDao.getTotalUsers();
    }

    @Override
    @Transactional
    public void saveCustomer(User user) {
        userDao.saveCustomers(user);
    }

    @Override
    public List<User> findUsersByPhoneNumber(String phoneNumber,int page, int size) {

        return userDao.findUsersByPhoneNumber(phoneNumber,page,size);
    }

    @Override
    public long getTotalUsersByPhoneNumber(String phoneNumber) {

        return userDao.getTotalUsersByPhoneNumber(phoneNumber);
    }

    public void changeUserStatus(Long userId, int status) {

        userDao.changeUserStatus(userId,status);
    }

}
