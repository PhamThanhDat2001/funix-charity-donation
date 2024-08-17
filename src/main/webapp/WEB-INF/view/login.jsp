<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <style>
    /* Reset các margin và padding mặc định của trang */
    body, html {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background-color: #f0f0f0; /* Màu nền của trang */
    }

    /* Phần wrapper bao quanh form đăng nhập */
    .login-form-container {
        max-width: 400px; /* Chiều rộng tối đa của form */
        margin: 50px auto; /* Canh giữa form */
        background: #fff; /* Màu nền của form */
        padding: 20px; /* Khoảng cách padding bên trong form */
        border-radius: 5px; /* Bo tròn các góc của form */
        box-shadow: 0 0 10px rgba(0,0,0,0.1); /* Đổ bóng cho form */
    }

    /* Định dạng cho các label trong form */
    label {
        display: block; /* Hiển thị label mỗi dòng */
        margin-bottom: 5px; /* Khoảng cách dưới của label */
        font-weight: bold; /* Chữ in đậm */
    }

    /* Định dạng cho các input trong form */
    input[type="email"],
    input[type="password"] {
        width: 100%; /* Chiều rộng input */
        padding: 8px; /* Khoảng cách padding */
        margin-bottom: 10px; /* Khoảng cách giữa các input */
        border: 1px solid #ccc; /* Đường viền input */
        border-radius: 4px; /* Độ cong viền */
    }

    /* Định dạng cho nút Submit */
    input[type="submit"] {
        width: 100%; /* Chiều rộng của nút */
        padding: 10px; /* Khoảng cách padding bên trong nút */
        background-color: #007bff; /* Màu nền của nút */
        border: none; /* Bỏ viền của nút */
        color: #fff; /* Màu chữ của nút */
        cursor: pointer; /* Đổi con trỏ khi di chuyển vào nút */
        border-radius: 3px; /* Bo tròn các góc của nút */
    }

    /* Định dạng cho nút Submit khi rê chuột vào */
    input[type="submit"]:hover {
        background-color: #0056b3; /* Màu nền thay đổi khi hover */
    }

    /* Định dạng cho thông báo lỗi */
    .error-message {
        color: red; /* Màu chữ đỏ */
        font-size: 14px; /* Cỡ chữ */
        margin-top: 10px; /* Khoảng cách từ đầu form đến thông báo lỗi */
    }

    </style>
</head>
<body>
    <div class="login-form-container">
        <form action="${pageContext.request.contextPath}/user/login" method="POST">
            <table>
                <tbody>
                    <tr>
                        <td><label>Email:</label></td>
                        <td><input type="email" name="email"/></td>
                    </tr>
                    <tr>
                        <td><label>Mật khẩu:</label></td>
                        <td><input type="password" name="password" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Login" class="save" /></td>
                    </tr>
                </tbody>
            </table>
            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
        </form>
    </div>
</body>
</html>
