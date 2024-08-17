<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Donation</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../resources/css/details.css">
    <style>
        .main {
            display: flex;
        }
        .left, .right {
            flex: 1;
            width: 50%;
            padding: 10px;
        }
        .table-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        thead {
            background-color: #f2f2f2;
        }
        .tbody-container {
            flex: 1;
            overflow-y: auto;
            margin-top: 5px;
            background-color: #F8F9FA;
            padding: 10px;
        }

        .user-donation {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .user-donation i {
            margin-right: 15px;
            font-size: 24px;
        }
        .user-donation-info {
            display: flex;
            flex-direction: column;
        }
        .user-donation-info td {
            padding: 2px 0;
        }
        table tr th, table tr td {
            padding: 10px;
        }
        .tbody-container table tr {
            margin-bottom: 10px;
        }
        .tbody-container h4 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <a href="/user_donation/home" style="font-size: 20px;"><i class="bi bi-arrow-left-circle-fill"></i> Quay lại</a>
    <div class="main">
        <div class="left">
            <div class="table-container">
                <div class="user-donation-list">
              <div style="margin:40px;">
                <h5 style="color:#8DBC37;margin-bottom:20px;"><i class="bi bi-align-end"></i> Nội dung của đợt quyên góp</h5>
                              <c:forEach  var="donation" items="${donations}">
                              <p  style= "color: #8a8892;"> ${donation.name} </p>
                               </c:forEach>
                </div>
                    <h4 style="margin:40px;">Danh sách quyên góp</h4>
                    <c:forEach var="donation" items="${donations}">
                        <c:forEach var="userDonation" items="${donation.userDonations}">
                            <div class="user-donation">
                                <i style="margin-left:40px;" class="bi bi-person-circle"></i>
                                <div style="margin-left:20px;" class="user-donation-info">
                                    <td><b> ${userDonation.name}</b></td>
                                    <td><b></b> ${userDonation.created}</td>
                                    <td><b></b> ${userDonation.money} VND</td>
                                </div>
                            </div>
                        </c:forEach>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="right">
            <div class="tbody-container">
                <h4 style="color:#8DBC37;">Thông tin</h4>
                <table>
                    <tbody>
                    <c:forEach var="donation" items="${donations}">
                        <tr>
                            <th>Mã Đợt quyên góp: </th>
                            <td>${donation.code}</td>
                        </tr>
                        <tr>
                            <th>Ngày bắt đầu: </th>
                            <td>${donation.startDate}</td>
                        </tr>
                        <tr>
                            <th>Tên tổ chức: </th>
                            <td>${donation.organizationName}</td>
                        </tr>
                        <tr>
                            <th>Trạng thái: </th>
                            <td>
                                <c:choose>
                                    <c:when test="${donation.status == '0'}">Mới tạo</c:when>
                                    <c:when test="${donation.status == '1'}">Đang quyên góp</c:when>
                                    <c:when test="${donation.status == '2'}">Kết thúc quyên góp</c:when>
                                    <c:when test="${donation.status == '3'}">Đóng quyên góp</c:when>
                                    <c:otherwise>Không xác định</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Tổng tiền: </th>
                            <td>${donation.money}</td>
                        </tr>
                        <tr>
                            <th>Ngày kết thúc: </th>
                            <td>${donation.endDate}</td>
                        </tr>
                        <tr>
                            <th>Tên đợt quyên góp: </th>
                            <td>${donation.name}</td>
                        </tr>
                        <tr>
                            <th>Số điện thoại: </th>
                            <td>${donation.phoneNumber}</td>
                        </tr>
                        <tr>
                            <th>Nội dung: </th>
                            <td>${donation.description}</td>
                        </tr>

                            <tr>
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
    </div>
</div>

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
                <form:form action="donation_detail" modelAttribute="donation" method="POST">
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
    function updatePageSize() {
        var pageSize = document.getElementById('pageSizeSelect').value;
        var currentUrl = window.location.href;
        var newUrl = new URL(currentUrl);
        newUrl.searchParams.set('pageSize', pageSize);
        newUrl.searchParams.set('page', 0); // Reset to the first page
        window.location.href = newUrl.toString();
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

