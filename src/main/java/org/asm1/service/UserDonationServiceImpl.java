package org.asm1.service;

import org.asm1.dao.UserDonationDao;
import org.asm1.entity.Donation;
import org.asm1.entity.UserDonation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import javax.transaction.Transactional;
import java.util.List;

@Service
public class UserDonationServiceImpl implements UserDonationService {
    @Autowired
  private  UserDonationDao donationDao;

    @Override
    @Transactional
    public List<UserDonation>  getUserDonation(int donationId) {
        return donationDao.getUserDonation(donationId);
    }

    @Override
    @Transactional
    public List<UserDonation> getCustomers() {
        return donationDao.getCustomers();
    }

    @Override
    @Transactional
    public List<Donation> getAllDonationsWithUserDonations() {
        return donationDao.getAllDonationsWithUserDonations();
    }

    @Override
    @Transactional
    public List<Donation> getAllDonationsWithUserDonations(int id) {
        return donationDao.getAllDonationsWithUserDonations(id);
    }

    @Override
    @Transactional
    public void updateUserDonationStatus(int UserDonationId, int status) {
        donationDao.updateUserDonationStatus(UserDonationId,status);
    }

    @Override
    @Transactional
    public void deleteUserDonation(int id) {
        donationDao.deleteUserDonation(id);
    }

    @Override
    @Transactional
    public List<Donation> getAllDonationsWithUserDonations(int id, int page, int size) {

        return donationDao.getAllDonationsWithUserDonations(id,page,size);
    }


    @Override
    @Transactional
    public long getTotalDonations(int id) {

        return donationDao.getTotalDonations(id);
    }


    @Transactional
    public List<UserDonation> getUserDonations(int donationId, int page, int size) {
        return donationDao.getUserDonations(donationId, page, size);
    }

    @Transactional
    public long getUserDonationsCount(int donationId) {
        return donationDao.getUserDonationsCount(donationId);
    }


    public List<UserDonation> searchUserDonationsByName(int userId, String name, int page, int pageSize) {
        return donationDao.searchUserDonationsByName(userId, name, page, pageSize);
    }

    public long countUserDonationsByName(int userId, String name) {
        return donationDao.countUserDonationsByName(userId, name);
    }

    @Override
    @Transactional
    public void saveUserDonation(UserDonation userDonation) {
        donationDao.saveUserDonation(userDonation);
    }
}
