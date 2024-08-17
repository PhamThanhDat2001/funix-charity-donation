<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>Website Quyên Góp</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="../resources/css/header.css">
    <style>
        body, html {
            margin: 0;
            padding: 0;
        }

        .footer {
                    margin-top:40px;
                    padding: 10px 0;
                    text-align: center;
                    width: 100%;
                    position: relative;
                    bottom: 0;
                }
                .table-bordered td, .table-bordered th {
                    border-right: none !important;
                    border-left: none !important;
                       color: #8a8892; /* Màu text trong table */
                }
                h3 {
                          text-align: center; /* Canh giữa cho h3 */
                       margin:50px;
                      }

          .table-hover tbody tr:hover {
                   background-color: #f5f5f5;
               }

               a {
                   text-decoration: none;
                   color: inherit;
               }

               .link {
                   color: black;
               }

               .link:hover {
                   cursor: pointer;
                   color: blue;
               }
    </style>
</head>
<body>
  <header>
        <img class="header" src="../resources/images/header.jpeg" alt="Hình ảnh">
        <button class="login-button" onclick="redirectToLogin()"><i class="bi bi-lock"></i>Đăng nhập</button>
    </header>

    <div class="container">
        <h3>Các đợt khuyên góp</h3>
        <div class="tbody-container">
            <table class="table table-bordered">
                <tbody>
                    <c:forEach var="donation" items="${donations}">
                        <tr>
                            <td><a class="link" onclick="redirectDetailDonationName(${donation.id})"><b style="color: black;">${donation.name}</b></a>
                            <br>
                            <c:choose>
                                    <c:when test="${donation.status == '0'}">Mới tạo</c:when>
                                    <c:when test="${donation.status == '1'}">Đang quyên góp</c:when>
                                    <c:when test="${donation.status == '2'}">Kết thúc quyên góp</c:when>
                                    <c:when test="${donation.status == '3'}">Đóng quyên góp</c:when>
                                    <c:otherwise>Không xác định</c:otherwise>
                                </c:choose></td>

                            <td>
                            Ngày bắt đầu
                            <br>
                            ${donation.startDate}
                            </td>

                            <td>
                            Ngày kết thúc
                            <br>${donation.endDate}
                            </td>

                            <td>
                            <i class="bi bi-geo-alt-fill"></i>

                            ${donation.organizationName}
                            <br>
                            ${donation.phoneNumber}
                            </td>

                        <td>
                               <c:if test="${donation.status == '1'}">
<button data-toggle="modal" data-target="#exampleModalScrollable" class="btn btn-success" onclick="editDonation(${donation.id})">Quyên góp</button>
                               </c:if>
                           </td>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <footer class="footer">
        <div class="section">
            <h3>Giới thiệu</h3>
            <p>Hỗ trợ</p>
            <p>Điều khoản</p>
            <p>Bảo mật & Dịch vụ</p>
        </div>
        <div class="section">
            <h3>Thông tin</h3>
            <p>Đợi khuyên góp</p>
            <p>Nhà khuyên góp</p>
        </div>
        <div class="section">
            <h3>Liên hệ</h3>
            <p>SDT: 0854295715</p>
            <p>Mạng xã hội: phamdat</p>
        </div>
        <div class="section">
            <h3>Kết nối</h3>
            <i class="bi bi-facebook"></i>
            <i class="bi bi-instagram"></i>
            <i class="bi bi-twitch"></i>
            <i class="bi bi-youtube"></i>
        </div>
        <p class="copyright">&copy; 2024 Website Quyên Góp. All rights reserved.</p>
    </footer>

<!-- Modal -->
<div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalScrollableTitle">Khuyên góp</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form action="donation" modelAttribute="donation" method="POST">
                    <table>
                        <tbody>
                            <!-- Hidden input field for 'id' -->
                                <form:hidden path="id" />
                            <tr>
                                <td><label>Họ và tên:</label></td>
                                <td><form:input path="name" required="true" /></td>
                            </tr>
                            <tr>
                                <td><label>Số tiền quyên góp:</label></td>
                                <td><form:input path="money" required="true"/></td>
                            </tr>
                            <tr>
                                 <td><label>Lời nhắn:</label></td>
                                <td><form:textarea style="resize: both; width: 100%;"  path="text" required="true"/></td>
                            </tr>

                            <td><form:hidden id="donationIdInput" path="donation.id" required="true" readonly="true"/></td>
                            <td><form:hidden path="user.id" required="true" value = "1" readonly="true"/></td>

                             <form:hidden path="created" />
                              <form:hidden path="status" />
                            <hr>
                         <tr>
                             <td colspan="2" class="text-right" id="bt">
                                 <button type="button" class="btn btn-secondary mr-2" data-dismiss="modal">Đóng</button>
                                 <input type="submit" value="Save" class="save btn btn-primary" />
                             </td>
                         </tr>

                        </tbody>
                    </table>
                </form:form>
            </div>

        </div>
    </div>
</div>

    <script>
        function redirectToLogin() {
            window.location.href = "${pageContext.request.contextPath}/user/login";
        }

        function redirectDetailDonationName(donationId) {
            window.location.href = "${pageContext.request.contextPath}/user_donation/name?id=" + donationId;
        }

        // Function to edit
        function editDonation(id) {
            // Đổ dữ liệu vào các trường input của modal
            document.getElementById('donationIdInput').value = id;

            // Hiển thị modal
            $('#exampleModalScrollable').modal('show');
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4xF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
