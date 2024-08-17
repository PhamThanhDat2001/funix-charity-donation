package org.asm1.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "donation")
public class Donation {

    @Id
    @Column(name="id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "code")
    private String code;

    @Column(name = "created")
    private String created;

    @Column(name = "description")
    private String description;

    @Column(name = "end_date")
    private String endDate;

    @Column(name = "money")
    private int money;

    @Column(name = "name")
    private String name;

    @Column(name = "organization_name")
    private String organizationName;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "start_date")
    private String startDate;

    @Column(name = "status")
    private int status;

    @OneToMany(mappedBy = "donation",cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserDonation> userDonations;

    // Getters and Setters


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<UserDonation> getUserDonations() {
        return userDonations;
    }

    public void setUserDonations(List<UserDonation> userDonations) {
        this.userDonations = userDonations;
    }

    @Override
    public String toString() {
        return "Donation{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", created='" + created + '\'' +
                ", description='" + description + '\'' +
                ", endDate='" + endDate + '\'' +
                ", money=" + money +
                ", name='" + name + '\'' +
                ", organizationName='" + organizationName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", startDate='" + startDate + '\'' +
                ", status=" + status +
                ", userDonations=" + userDonations +
                '}';
    }
}
