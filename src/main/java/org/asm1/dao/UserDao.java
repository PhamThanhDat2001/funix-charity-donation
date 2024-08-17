package org.asm1.dao;

import org.asm1.entity.User;



import org.springframework.stereotype.Repository;

import java.awt.print.Pageable;
import java.util.List;

@Repository
public interface UserDao  {
    User findByEmailAndPassword(String email, String password);
    public List<User> getUser();

    public List<User> getUser(int page, int size);
    public long getTotalUsers();

    public void saveCustomers(User user);

    List<User> findUsersByPhoneNumber(String phoneNumber,int page, int size);
    public long getTotalUsersByPhoneNumber(String phoneNumber);

    void changeUserStatus(Long userId, int status);


    public void deleteUser(int id);

    public User getUserById(int id);
}
