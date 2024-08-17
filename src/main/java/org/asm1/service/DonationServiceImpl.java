package org.asm1.service;

import org.asm1.dao.DonationDao;
import org.asm1.dao.UserDao;
import org.asm1.entity.Donation;
import org.asm1.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class DonationServiceImpl implements DonationService {
    @Autowired
    private DonationDao donationDao;

    @Override
    @Transactional
    public List<Donation> getDonation() {
        return donationDao.getDonation();
    }


    @Transactional
    public List<Donation> getPaginatedDonations(int page, int size) {
        int start = (page - 1) * size;
        return donationDao.getPaginatedDonations(start, size);
    }

    @Transactional
    public int getTotalDonations() {
        return donationDao.getTotalDonations();
    }

    @Override
    @Transactional
    public void saveDonation(Donation donation) {
        donationDao.saveDonation(donation);
    }

    @Override
    @Transactional
    public List<Donation> filterDonationsByStatusPhoneNumberOrganizationNameCode(String find, int page, int size) {
        return donationDao.filterDonationsByStatusPhoneNumberOrganizationNameCode(find,page,size);
    }

    @Override
    @Transactional
    public int getTotalDonationsByStatusPhoneNumberOrganizationNameCode(String search) {
        return donationDao.getTotalDonationsByStatusPhoneNumberOrganizationNameCode(search);
    }

    @Override
    @Transactional
    public void deleteDonation(int id) {
        donationDao.deleteDonation(id);
    }

    @Override
    @Transactional
    public void updateDonationStatus(int donationId, int status) {
        donationDao.updateDonationStatus(donationId,status);
    }

    @Override
    @Transactional
    public Donation getDonations(int id) {
        return donationDao.getDonations(id);
    }
}
