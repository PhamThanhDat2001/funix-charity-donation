package org.asm1.dao;

import org.asm1.entity.Donation;
import org.asm1.entity.UserDonation;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDonationDaoImpl implements UserDonationDao{
    @Autowired
    private SessionFactory sessionFactory;

    //    sử dụng JdbcTemplate để thực hiện các thao tác cơ sở dữ liệu
//    giúp đơn giản hóa việc tương tác với cơ sở dữ liệu bằng JDBC
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Override
    public List<UserDonation> getUserDonation(int donationId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<UserDonation> query = currentSession.createQuery("from UserDonation where donation.id = :donationId", UserDonation.class);
        query.setParameter("donationId", donationId);
        return query.getResultList();
    }

    @Override
    public List<UserDonation> getCustomers() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<UserDonation> query = currentSession.createQuery("from UserDonation", UserDonation.class);
        return query.getResultList();
    }

//    @Override
//    public List<Donation> getAllDonationsWithUserDonations() {
//        Session currentSession = sessionFactory.getCurrentSession();
//        Query<Donation> query = currentSession.createQuery(
//                "select distinct d from Donation d left join fetch d.userDonations", Donation.class
//        );
//        return query.getResultList();
//    }


    @Override
    public List<Donation> getAllDonationsWithUserDonations() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> query = currentSession.createQuery(
                "select distinct d from Donation d join fetch d.userDonations ud where ud.donation.id = d.id",
                Donation.class
        );
        return query.getResultList();
    }





    @Override
    public List<Donation> getAllDonationsWithUserDonations(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> query = currentSession.createQuery(
                "select distinct d from Donation d left join fetch d.userDonations ud where d.id = :id",
                Donation.class
        );
        query.setParameter("id", id);
        return query.getResultList();
    }

    public List<Donation> getAllDonationsWithUserDonations(int theId, int page, int size) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> query = currentSession.createQuery(
                "select distinct d from Donation d join fetch d.userDonations ud where ud.donation.id = :donationId",
                Donation.class
        );
        query.setParameter("donationId", theId);
        query.setFirstResult(page * size);
        query.setMaxResults(size);
        return query.getResultList();
    }

    @Override
    public void updateUserDonationStatus(int UserDonationId, int status) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query query = currentSession.createQuery("update UserDonation set status = :status where id = :UserDonationId");
        query.setParameter("status", status);
        query.setParameter("UserDonationId", UserDonationId);
        query.executeUpdate();
    }




    public long getTotalDonations(int theId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Long> query = currentSession.createQuery(
                "select count(distinct d) from Donation d join d.userDonations ud where ud.donation.id = :donationId",
                Long.class
        );
        query.setParameter("donationId", theId);
        return query.getSingleResult();
    }



    @Override
    public void deleteUserDonation(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery =
                currentSession.createQuery("delete from UserDonation where id=:donationId");
        theQuery.setParameter("donationId",id);
        theQuery.executeUpdate();
    }



    public List<UserDonation> getUserDonations(int donationId, int page, int size) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<UserDonation> query = currentSession.createQuery(
                "from UserDonation where donation.id = :donationId  order by status",
                UserDonation.class
        );
        query.setParameter("donationId", donationId);
        query.setFirstResult(page * size);
        query.setMaxResults(size);
        return query.getResultList();
    }

    public long getUserDonationsCount(int donationId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Long> query = currentSession.createQuery(
                "select count(*) from UserDonation where donation.id = :donationId",
                Long.class
        );
        query.setParameter("donationId", donationId);
        return query.getSingleResult();
    }


    public List<UserDonation> searchUserDonationsByName(int userId, String name, int page, int pageSize) {
        String sql = "SELECT * FROM user_donation WHERE user_id = ? AND name LIKE ? LIMIT ?, ?";
        int start = page * pageSize;
        return jdbcTemplate.query(sql, new Object[]{userId, "%" + name + "%", start, pageSize}, BeanPropertyRowMapper.newInstance(UserDonation.class));
    }

    public long countUserDonationsByName(int userId, String name) {
        String sql = "SELECT COUNT(*) FROM user_donation WHERE user_id = ? AND name LIKE ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{userId, "%" + name + "%"}, Long.class);
    }

    @Override
    public void saveUserDonation(UserDonation userDonation) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(userDonation);
    }
}
