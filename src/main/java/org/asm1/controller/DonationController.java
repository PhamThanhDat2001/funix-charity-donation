package org.asm1.controller;

import org.asm1.entity.Donation;
import org.asm1.entity.Role;
import org.asm1.entity.User;
import org.asm1.service.DonationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/donation")
public class DonationController {
    @Autowired
    private DonationService donationService;

    // Đổi trạng thái từ mới tạo sang khuyên góp
    @PostMapping("/donate")
    public String donate(@RequestParam("donationId") int donationId) {
        donationService.updateDonationStatus(donationId, 1);
        // chuyển đến url
        return "redirect:/donation/admin";
    }

    // Đổi trạng thái từ đang quyên góp sang kết thúc khuyên góp
    @PostMapping("/end")
    public String endDonation(@RequestParam("donationId") int donationId) {
        donationService.updateDonationStatus(donationId, 2);
        return "redirect:/donation/admin";
    }

    // Đổi trạng thái từ kết thúc khuyên góp sang đóng quyên góp
    @PostMapping("/close")
    public String closeDonation(@RequestParam("donationId") int donationId) {
        donationService.updateDonationStatus(donationId, 3);
        return "redirect:/donation/admin";
    }

    // lấy ra dữ liệu, phân trang, tìm kiếm
    //request lấy dữ liệu từ url
    @GetMapping("/admin")
    public String listDonations(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "search", required = false) String search,
            Model theModel) {

        List<Donation> donations;
        int totalDonations;

        if (search != null && !search.isEmpty()) {
            // If search parameter is provided, perform search
            donations = donationService.filterDonationsByStatusPhoneNumberOrganizationNameCode(search, page, size);
            totalDonations = (int) donationService.getTotalDonationsByStatusPhoneNumberOrganizationNameCode(search);
        } else {
            // If no search parameter, fetch regular donations
            donations = donationService.getPaginatedDonations(page, size);
            totalDonations = donationService.getTotalDonations();
        }

        // page hiện số bản ghi từ bao nhiêu đến bao nhiêu vd
        // showing 1 to 3 of
        int startEntry = (page - 1) * size + 1;
        int endEntry = Math.min(page * size, totalDonations);
        // tính số bản ghi của page
        int totalPages = (int) Math.ceil((double) totalDonations / size);

        theModel.addAttribute("donations", donations);
        theModel.addAttribute("currentPage", page);
        theModel.addAttribute("pageSize", size);
        theModel.addAttribute("totalPages", totalPages);
        theModel.addAttribute("startEntry", startEntry);
        theModel.addAttribute("endEntry", endEntry);
        theModel.addAttribute("totalDonations", totalDonations);
        theModel.addAttribute("search", search);
        // Add an empty donation object for the form
        theModel.addAttribute("donation", new Donation());
        return "manage-donation";
    }

    // thêm bản ghi
    @PostMapping("/admin")
    public String saveDonation(@ModelAttribute Donation  donation) {
        donationService.saveDonation(donation);
        return "redirect:/donation/admin";
    }

    // xóa bản ghi
    @GetMapping("/delete")
    public String deleteUser(@RequestParam("donationId") int theId ) {
        donationService.deleteDonation(theId);
        return "redirect:/donation/admin";
    }

}
