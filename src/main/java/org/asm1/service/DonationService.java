package org.asm1.service;

import org.asm1.entity.Donation;
import org.asm1.entity.User;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface DonationService {
    public List<Donation> getDonation();

    public List<Donation> getPaginatedDonations(int start, int size);
    public int getTotalDonations();

    public void saveDonation(Donation donation);

    List<Donation> filterDonationsByStatusPhoneNumberOrganizationNameCode(String find,int page, int size);
    int getTotalDonationsByStatusPhoneNumberOrganizationNameCode(String search);
    public void deleteDonation(int id);

    public void updateDonationStatus(int donationId, int status);


    public Donation getDonations(int id);
}
