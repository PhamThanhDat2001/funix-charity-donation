package org.asm1.controller;

import org.asm1.dao.UserDonationDaoImpl;
import org.asm1.entity.Donation;
import org.asm1.entity.User;
import org.asm1.entity.UserDonation;
import org.asm1.service.DonationService;
import org.asm1.service.UserDonationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/user_donation")
public class UserDonationController {
    @Autowired
    private UserDonationService userDonationService;

    // lấy ra dữ liệu, phân trang, tìm kiếm
    @GetMapping("")
    public String details(@RequestParam("id") int theId,
                          @RequestParam(value = "page", defaultValue = "0") int page,
                          @RequestParam(value = "pageSize", defaultValue = "5") int pageSize,
                          @RequestParam(value = "name", required = false) String name,
                          Model theModel) {

        List<UserDonation> userDonations;
        long totalDonations;
        int totalPages;

        if (name != null && !name.isEmpty()) {
            // Tìm kiếm theo tên
            userDonations = userDonationService.searchUserDonationsByName(theId, name, page, pageSize);
            totalDonations = userDonationService.countUserDonationsByName(theId, name);
        } else {
            // Lấy danh sách đóng góp theo trang và kích thước trang
            userDonations = userDonationService.getUserDonations(theId, page, pageSize);
            totalDonations = userDonationService.getUserDonationsCount(theId);
        }

        // Tính tổng số trang
        totalPages = (int) Math.ceil((double) totalDonations / pageSize);

        // Tính startEntry và endEntry cho thông báo số mục
        int startEntry = page * pageSize + 1;
        int endEntry = (int) Math.min((page + 1) * pageSize, totalDonations);

        // Đưa các attribute vào model
        theModel.addAttribute("startEntry", startEntry);
        theModel.addAttribute("endEntry", endEntry);
        theModel.addAttribute("totalDonations", totalDonations);
        theModel.addAttribute("userDonations", userDonations);
        theModel.addAttribute("currentPage", page);
        theModel.addAttribute("totalPages", totalPages);
        theModel.addAttribute("pageSize", pageSize);
        theModel.addAttribute("id", theId);

        // Lấy danh sách các đóng góp
        List<Donation> donations = userDonationService.getAllDonationsWithUserDonations(theId);
        theModel.addAttribute("donations", donations);

        return "detail";
    }

    // lấy ra danh sách
    @GetMapping("/home")
    public String details(Model theModel) {
        // Log kiểm tra
        System.out.println("Controller /home được gọi");


        // Lấy danh sách các đóng góp
        List<Donation> donations = userDonationService.getAllDonationsWithUserDonations();
        theModel.addAttribute("donations", donations);

        theModel.addAttribute("donation", new UserDonation());

        // Log dữ liệu
        System.out.println("Donations: " + donations);
        return "home";
    }



    // xác nhận donate
    @PostMapping("/confirmation")
    public String confirmation(@RequestParam("UserDonationId") String userDonationIdStr, @RequestParam("donationId") String donationIdStr) {


        int userDonationId = Integer.parseInt(userDonationIdStr);
        int donationId = Integer.parseInt(donationIdStr);
        userDonationService.updateUserDonationStatus(userDonationId, 1);
        return "redirect:/user_donation?id=" + donationId;
    }

    // huỷ donate
    @PostMapping("/cancel")
    public String cancel(@RequestParam("UserDonationId") String userDonationIdStr, @RequestParam("donationId") String donationIdStr) {
        System.out.println("a" +userDonationIdStr);
        System.out.println("b" +donationIdStr);

        int userDonationId = Integer.parseInt(userDonationIdStr);
        int donationId = Integer.parseInt(donationIdStr);
        userDonationService.updateUserDonationStatus(userDonationId, 0);
        return "redirect:/user_donation?id=" + donationId;
    }

    // xóa donate
    @PostMapping("/delete")
    public String delete(@RequestParam("UserDonationId") String userDonationIdStr, @RequestParam("donationId") String donationIdStr) {

        System.out.println("a" +userDonationIdStr);
        System.out.println("b" +donationIdStr);
        int userDonationId = Integer.parseInt(userDonationIdStr);
        int donationId = Integer.parseInt(donationIdStr);
        userDonationService.deleteUserDonation(userDonationId);
        return "redirect:/user_donation?id=" + donationId;
    }

    // khi bấm vào name trong danh sách thì chuyển trang và xem chi tiết
    @GetMapping("/name")
    public String detailsDonationName(@RequestParam("id") int theId,Model theModel) {
        // Lấy danh sách các đóng góp
        List<Donation> donations = userDonationService.getAllDonationsWithUserDonations(theId);
        theModel.addAttribute("donations", donations);
        theModel.addAttribute("donation", new UserDonation());
// Log dữ liệu
        System.out.println("Donations: " + donations);
        return "detail-donation-name";
    }

    // thêm donate ở trang home
    @PostMapping("/donation")
    public String saveDonation(@ModelAttribute("donation") UserDonation userDonation, Model theModel) {
        // Set default values if necessary
        userDonation.setCreated(LocalDate.now().toString());
        userDonation.setStatus(0); // Assuming status is an int, no need to parse from String
        // Save the user donation
        userDonationService.saveUserDonation(userDonation);
        // Add userDonation object to the model
        theModel.addAttribute("userDonation", userDonation);


//        theModel.addAttribute("donation", new UserDonation());

        return "redirect:/user_donation/home";
    }
    // thêm donate ở trang detail
 @PostMapping("/donation_detail")
    public String saveDonationDetail(@ModelAttribute("donation") UserDonation userDonation, Model theModel) {
        // Set default values if necessary
        userDonation.setCreated(LocalDate.now().toString());
        userDonation.setStatus(0); // Assuming status is an int, no need to parse from String
        // Save the user donation
        userDonationService.saveUserDonation(userDonation);
        // Add userDonation object to the model
        theModel.addAttribute("userDonation", userDonation);


//        theModel.addAttribute("donation", new UserDonation());

        return "redirect:/user_donation/name?id=" + userDonation.getDonation().getId();
    }

}
