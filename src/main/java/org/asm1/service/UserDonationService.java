package org.asm1.service;

import org.asm1.entity.Donation;
import org.asm1.entity.UserDonation;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserDonationService{
    public List<UserDonation> getUserDonation(int donationId);
    public List<UserDonation> getCustomers();
    public List<Donation> getAllDonationsWithUserDonations() ;
    public List<Donation> getAllDonationsWithUserDonations(int id);

    public void updateUserDonationStatus(int UserDonationId, int status);
    public void deleteUserDonation(int id);


    public List<Donation> getAllDonationsWithUserDonations(int id, int page, int size);
    public long getTotalDonations(int id);

    public List<UserDonation> getUserDonations(int donationId, int page, int size);
    public long getUserDonationsCount(int donationId);


    public List<UserDonation> searchUserDonationsByName(int userId, String name, int page, int pageSize);

    public long countUserDonationsByName(int userId, String name) ;

    public void saveUserDonation(UserDonation userDonation);
}
