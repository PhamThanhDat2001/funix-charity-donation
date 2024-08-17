package org.asm1.dao;

import org.asm1.entity.Donation;
import org.asm1.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DonationDao {
    public List<Donation> getDonation();
    public List<Donation> getPaginatedDonations(int start, int size);
    public int getTotalDonations();
    public void saveDonation(Donation donation);

    List<Donation> filterDonationsByStatusPhoneNumberOrganizationNameCode(String find,int page, int size);
    public int getTotalDonationsByStatusPhoneNumberOrganizationNameCode(String phoneNumber);
    public void deleteDonation(int id);

    public void updateDonationStatus(int donationId, int status);

    public Donation getDonations(int id);
}
