package org.asm1.service;

import org.asm1.entity.User;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;


import java.awt.print.Pageable;
import java.util.List;

@Service
public interface UserService {
    User findByEmailAndPassword(String email, String password);
    public List<User> getUser();

    public List<User> getUser(int page, int size);
    public long getTotalUsers();


    public void saveCustomer(User user);

    List<User> findUsersByPhoneNumber(String phoneNumber,int page, int size);
    public long getTotalUsersByPhoneNumber(String phoneNumber);

    void changeUserStatus(Long userId, int status);
    public void deleteUser(int id);
    public User getUserById(int id);
}
