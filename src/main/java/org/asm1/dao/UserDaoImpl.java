package org.asm1.dao;

import org.asm1.entity.Role;
import org.asm1.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.persistence.TypedQuery;
import java.awt.print.Pageable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserDaoImpl implements UserDao{
    @Autowired
    private SessionFactory sessionFactory;

//    sử dụng JdbcTemplate để thực hiện các thao tác cơ sở dữ liệu
//    giúp đơn giản hóa việc tương tác với cơ sở dữ liệu bằng JDBC
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Override
    public User findByEmailAndPassword(String email, String password) {
        Session currentSession = sessionFactory.getCurrentSession();

        // Tạo một câu truy vấn sử dụng HQL (Hibernate Query Language)
        String hql = "FROM User WHERE email = :email AND password = :password";
        Query<User> query = currentSession.createQuery(hql, User.class);
        query.setParameter("email", email);
        query.setParameter("password", password);

        // Lấy danh sách kết quả (danh sách User)
        List<User> results = query.getResultList();

        // Kiểm tra xem có kết quả nào hay không
        if (!results.isEmpty()) {
            // Nếu có kết quả, trả về user đầu tiên trong danh sách (do email là duy nhất)
            return results.get(0);
        } else {
            // Nếu không có kết quả, trả về null
            return null;
        }
    }

    @Override
    public List<User> getUser() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<User> theQuery =
                currentSession.createQuery("from User",User.class);
        List<User> users = theQuery.getResultList();
        return users;
    }

    @Override
    public void deleteUser(int id) {
        // Sử dụng JdbcTemplate để xóa tất cả các bản ghi liên quan trong bảng user_donation
        jdbcTemplate.update("DELETE FROM user_donation WHERE user_id = ?", id);

        // Sử dụng Hibernate Session để xóa người dùng
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createQuery("delete from User where id=:userId");
        theQuery.setParameter("userId", id);

        theQuery.executeUpdate();
    }

    @Override
    public User getUserById(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        User user = currentSession.get(User.class,id);
        return user;
    }


//    @Override
//    public List<User> getUser(int page, int size) {
//        String sql = "SELECT * FROM user LIMIT ?, ?";
//        int offset = page * size;
//        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(User.class), offset, size);
//    }

    public List<User> getUser(int page, int size) {
        String sql = "SELECT u.*, r.role_name FROM user u JOIN role r ON u.role_id = r.id LIMIT ?, ?";
        int offset = page * size;
        return jdbcTemplate.query(sql, new RowMapper<User>() {
            @Override
            public User mapRow(ResultSet rs, int rowNum) throws SQLException {
                User user = new BeanPropertyRowMapper<>(User.class).mapRow(rs, rowNum);
                Role role = new Role();
                role.setRoleName(rs.getString("role_name"));
                user.setRole(role);
                return user;
            }
        }, offset, size);
    }


    @Override
    public long getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM user";
        return jdbcTemplate.queryForObject(sql, Long.class);
    }


    @Override
    public void saveCustomers(User user) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(user);
    }
//    @Override
//    public List<User> findUsersByPhoneNumber(String phoneNumber, int page, int size) {
//        String sql = "SELECT u.*, r.role_name FROM user u JOIN role r ON u.role_id = r.id WHERE phone_number LIKE ? LIMIT ?, ?";
//        int offset = page * size;
//        return jdbcTemplate.query(sql, new Object[]{"%" + phoneNumber + "%", offset, size},
//                new RowMapper<User>() {
//                    @Override
//                    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
//                        User user = new BeanPropertyRowMapper<>(User.class).mapRow(rs, rowNum);
//                        Role role = new Role();
//                        role.setRoleName(rs.getString("role_name"));
//                        user.setRole(role);
//                        return user;
//                    }
//                });
//    }

    @Override
    public List<User> findUsersByPhoneNumber(String searchTerm, int page, int size) {
        String sql = "SELECT u.*, r.role_name " +
                "FROM user u JOIN role r ON u.role_id = r.id " +
                "WHERE phone_number LIKE ? OR email LIKE ? " +
                "LIMIT ?, ?";
        int offset = page * size;
        return jdbcTemplate.query(sql, new Object[]{"%" + searchTerm + "%", "%" + searchTerm + "%", offset, size},
                new RowMapper<User>() {
                    @Override
                    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
                        User user = new BeanPropertyRowMapper<>(User.class).mapRow(rs, rowNum);
                        Role role = new Role();
                        role.setRoleName(rs.getString("role_name"));
                        user.setRole(role);
                        return user;
                    }
                });
    }

//
//    @Override
//    public long getTotalUsersByPhoneNumber(String phoneNumber) {
//        String sql = "SELECT COUNT(*) FROM user WHERE phone_number LIKE ?";
//        return jdbcTemplate.queryForObject(sql, Long.class, "%" + phoneNumber + "%");
//    }

    @Override
    public long getTotalUsersByPhoneNumber(String searchTerm) {
        String sql = "SELECT COUNT(*) FROM user WHERE phone_number LIKE ? OR email LIKE ?";
        return jdbcTemplate.queryForObject(sql, Long.class, "%" + searchTerm + "%", "%" + searchTerm + "%");
    }

    @Override
    public void changeUserStatus(Long userId, int status) {
        String sql = "UPDATE user SET status = ? WHERE id = ?";
        jdbcTemplate.update(sql, status, userId);
    }

}
