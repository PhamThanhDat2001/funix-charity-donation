package org.asm1.controller;

import org.asm1.entity.Donation;
import org.asm1.entity.Role;
import org.asm1.entity.User;
import org.asm1.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // Mapping cho trang đăng nhập GET
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    // Xóa user
    @GetMapping("/delete")
    public String deleteUser(@RequestParam("userId") int theId ) {
        userService.deleteUser(theId);
        return "redirect:/user/admin";
    }

    // Đổi trạng thái sang đã khóa
    @PostMapping("/lock")
    public String lockUser(@RequestParam("userId") Long userId) {
        userService.changeUserStatus(userId, 0); // Đặt trạng thái thành 0 (Đã khóa)
        return "redirect:/user/admin";
    }

    // Đổi trạng thái sang  Hoạt động
    @PostMapping("/unlock")
    public String unlockUser(@RequestParam("userId") Long userId) {
        userService.changeUserStatus(userId, 1); // Đặt trạng thái thành 1 (Hoạt động)
        return "redirect:/user/admin";
    }

    // đăng nhâp
    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        Model model) {

        // Kiểm tra email và password
        User user = userService.findByEmailAndPassword(email, password);

        if (user != null) {
            Role role = user.getRole();
            if (role != null && role.getId() == 1) {
                // Nếu vai trò là 1, chuyển hướng tới trang quản trị
                return "redirect:/user/admin";
            } else {
                // Nếu không phải vai trò admin , chuyển hướng tới trang chính
                return "redirect:/";
            }
        } else {
            // Nếu đăng nhập thất bại, hiển thị thông báo lỗi
            model.addAttribute("error", "Invalid email or password. Please try again.");
            return "login"; // Chuyển hướng trở lại trang đăng nhập với thông báo lỗi
        }
    }


// lấy ra dữ liệu
@GetMapping("/admin")
public String listCustomers(@RequestParam(name = "phoneNumber", required = false) String phoneNumber,
                            Model theModel,
                            @RequestParam(defaultValue = "0") int page,
                            @RequestParam(defaultValue = "5") int size) {

    List<User> theUser;
    long totalUsers;

    if (phoneNumber != null && !phoneNumber.isEmpty()) {
        // Nếu có phoneNumber được truyền, thực hiện tìm kiếm
        theUser = userService.findUsersByPhoneNumber(phoneNumber, page, size);
        totalUsers = userService.getTotalUsersByPhoneNumber(phoneNumber);
    } else {
        // Nếu không có phoneNumber, lấy danh sách người dùng bình thường
        theUser = userService.getUser(page, size);
        totalUsers = userService.getTotalUsers();
    }

    int startEntry = page * size + 1;
    int endEntry = Math.min((page + 1) * size, (int) totalUsers);

    theModel.addAttribute("users", theUser);
    theModel.addAttribute("currentPage", page);
    theModel.addAttribute("pageSize", size);
    theModel.addAttribute("totalUsers", totalUsers);
    theModel.addAttribute("startEntry", startEntry);
    theModel.addAttribute("endEntry", endEntry);
    theModel.addAttribute("searchedPhoneNumber", phoneNumber);
    theModel.addAttribute("donation", new Donation());
    // Thêm một đối tượng User mới để sử dụng trong modal thêm mới
    User theCustomer = new User();
    theModel.addAttribute("user", theCustomer);

    // Thêm thời gian hiện tại để sử dụng trong form thêm mới
    LocalDateTime now = LocalDateTime.now();
    theModel.addAttribute("now", now);

    return "admin";
}


    // cập nhật, thêm 1 user
    @PostMapping("/admin")
    public String saveCustomer(@ModelAttribute("user") User user,
                               @RequestParam(name = "size", defaultValue = "5") int size,
                               RedirectAttributes redirectAttributes, Model model) {
        userService.saveCustomer(user);
        redirectAttributes.addAttribute("page", 0); // Chỉ số trang (page) cần hiển thị
        redirectAttributes.addAttribute("size", size); // Số lượng bản ghi trên mỗi trang (size)

        // Redirect back to admin page with updated data
        return "redirect:/user/admin";
    }



}
