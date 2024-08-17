package org.asm1.dao;

import org.asm1.entity.Donation;
import org.asm1.entity.Role;
import org.asm1.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class DonationDAOImpl implements DonationDao{
    @Autowired
    private SessionFactory sessionFactory;
    //    sử dụng JdbcTemplate để thực hiện các thao tác cơ sở dữ liệu
//    giúp đơn giản hóa việc tương tác với cơ sở dữ liệu bằng JDBC
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Override
    public List<Donation> getDonation() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> theQuery =
                currentSession.createQuery("from Donation",Donation.class);
        List<Donation> donations = theQuery.getResultList();
        return donations;
    }

    @Override
    public List<Donation> getPaginatedDonations(int start, int size) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> theQuery = currentSession.createQuery("from Donation", Donation.class);
        theQuery.setFirstResult(start);
        theQuery.setMaxResults(size);
        return theQuery.getResultList();
    }

    @Override
    public int getTotalDonations() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Long> theQuery = currentSession.createQuery("select count(d) from Donation d", Long.class);
        return theQuery.uniqueResult().intValue();
    }

    @Override
    public void saveDonation(Donation donation) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(donation);
    }


    @Override
    public List<Donation> filterDonationsByStatusPhoneNumberOrganizationNameCode(String find, int page, int size) {
        String statusCondition = "(CASE " +
                "WHEN status = 0 THEN 'Mới tạo' " +
                "WHEN status = 1 THEN 'Đang quyên góp' " +
                "WHEN status = 2 THEN 'Kết thúc quyên góp' " +
                "ELSE 'Đóng quyên góp' " +
                "END LIKE ?)";

        String sql = "SELECT * FROM donation WHERE " + statusCondition +
                " OR phone_number LIKE ? OR organization_name LIKE ? OR code LIKE ? LIMIT ?, ?";
        int start = (page - 1) * size;

        // Thực hiện truy vấn với JdbcTemplate
        List<Donation> donations = jdbcTemplate.query(sql, new Object[]{
                "%" + find + "%",
                "%" + find + "%",
                "%" + find + "%",
                "%" + find + "%",
                start,
                size
        }, new BeanPropertyRowMapper<>(Donation.class));

        return donations;
    }


    @Override
    public int getTotalDonationsByStatusPhoneNumberOrganizationNameCode(String search) {
        String statusCondition = "(CASE " +
                "WHEN status = 0 THEN 'Mới tạo' " +
                "WHEN status = 1 THEN 'Đang quyên góp' " +
                "WHEN status = 2 THEN 'Kết thúc quyên góp' " +
                "ELSE 'Đóng quyên góp' " +
                "END) LIKE ?";

        String sql = "SELECT COUNT(*) FROM donation WHERE " + statusCondition +
                " OR phone_number LIKE ? OR organization_name LIKE ? OR code LIKE ?";

        // Append % to search string for partial matching
        String searchString = "%" + search + "%";

        // Execute query and retrieve count
        try {
            return jdbcTemplate.queryForObject(sql, Integer.class, searchString, searchString, searchString, searchString);
        } catch (EmptyResultDataAccessException e) {
            // Handle case where no results are found
            return 0;
        }
    }

    @Override
    public void deleteDonation(int id) {
        // Sử dụng JdbcTemplate để xóa tất cả các bản ghi liên quan trong bảng user_donation
        jdbcTemplate.update("DELETE FROM user_donation WHERE user_id = ?", id);

        // Sử dụng Hibernate Session để xóa người dùng
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createQuery("delete from Donation where id=:donationId");
        theQuery.setParameter("donationId", id);

        theQuery.executeUpdate();
    }
    @Override
    public void updateDonationStatus(int donationId, int status) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query query = currentSession.createQuery("update Donation set status = :status where id = :donationId");
        query.setParameter("status", status);
        query.setParameter("donationId", donationId);
        query.executeUpdate();
    }
//    @Override
//    public void updateDonationStatus(int donationId, int status) {
//        String sql = "UPDATE donation SET status = ? WHERE id = ?";
//        jdbcTemplate.update(sql, status, donationId);
//    }

    @Override
    public Donation getDonations(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        Donation donations = currentSession.get(Donation.class,id);
        return donations;
    }
}
