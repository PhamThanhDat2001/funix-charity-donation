<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .table-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        thead, tbody, tr, th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        thead {
            background-color: #f2f2f2;
        }

        .tbody-container {
            flex: 1;
            overflow-y: auto;
        }

        .btn {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <a href="/donation/admin" style="font-size: 20px;"><i class="bi bi-arrow-left-circle-fill"></i> Quay lại</a>
    <h2>Chi tiết Donation</h2>

       <div class="tbody-container">
            <table class="table table-bordered">
                <tbody>
                    <c:forEach var="donation" items="${donations}">
                        <tr>
                            <th>Mã Đợt khuyên góp</th>
                            <td>${donation.code}</td>
                        </tr>
                        <tr>
                            <th>Ngày bắt đầu</th>
                            <td>${donation.startDate}</td>
                        </tr>
                        <tr>
                            <th>Tên tổ chức</th>
                            <td>${donation.organizationName}</td>
                        </tr>
                        <tr>
                            <th>Trạng thái</th>
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
                            <th>Tổng tiền</th>
                            <td>${donation.money}</td>
                        </tr>
                        <tr>
                            <th>Ngày kết thúc</th>
                            <td>${donation.endDate}</td>
                        </tr>
                        <tr>
                            <th>Tên đợt khuyên góp</th>
                            <td>${donation.name}</td>
                        </tr>
                        <tr>
                            <th>Số điện thoại</th>
                            <td>${donation.phoneNumber}</td>
                        </tr>
                        <tr>
                            <th>Nội dung</th>
                            <td>${donation.description}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>


    <h3>Danh sách những người khuyên góp</h3>

   <div class="page-size">
       <label for="pageSizeSelect">Kích thước trang:</label>
       <select id="pageSizeSelect" class="form-control" style="width: auto; display: inline-block;" onchange="updatePageSize()">
           <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
           <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
           <option value="15" ${pageSize == 15 ? 'selected' : ''}>15</option>
       </select>
   </div>

<form action="/user_donation" method="get" class="form-inline">
    <div class="input-group">
        <input type="hidden" name="id" value="${id}">
        <input type="text" class="form-control" name="name" placeholder="Tìm kiếm theo tên" aria-label="Tìm kiếm theo tên" aria-describedby="button-addon2">
        <div class="input-group-append" style="margin-top:4.5px; margin-left:10px">
            <button class="btn btn-primary" type="submit" id="button-addon2">Tìm kiếm</button>
        </div>
    </div>
</form>


    <table class="table table-bordered">
        <thead>
            <tr>
                <th scope="col">Họ tên</th>
                <th scope="col">Tiền quyên góp</th>
                <th scope="col">Ngày khuyên góp</th>
                <th scope="col">Nội dung</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="userDonation" items="${userDonations}">
                <tr>
                    <td>${userDonation.name}</td>
                    <td>${userDonation.money}</td>
                    <td>${userDonation.created}</td>
                    <td>${userDonation.text}</td>
                    <td>
                        <c:choose>
                            <c:when test="${userDonation.status == 0}">Chờ xác nhận</c:when>
                            <c:when test="${userDonation.status == 1}">Xác nhận</c:when>
                        </c:choose>
                    </td>
                    <td class="action-buttons">
                         <c:choose>
                                <c:when test="${userDonation.status == 0}">
                                    <form action="/user_donation/delete" method="post">
                                        <input type="hidden" name="UserDonationId" value="${userDonation.id}">
                                        <input type="hidden" name="donationId" value="${id}">
                                        <button type="submit" class="btn btn-danger">Hủy xác nhận</button>
                                    </form>
                                    <form action="/user_donation/confirmation" method="post">
                                        <input type="hidden" name="UserDonationId" value="${userDonation.id}">
                                        <input type="hidden" name="donationId" value="${id}">
                                        <button type="submit" class="btn btn-primary">Xác nhận</button>
                                    </form>
                                </c:when>
                            </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
   <div class="dataTables_info" id="example_info" role="status" aria-live="polite">
          Showing ${startEntry} to ${endEntry} of ${totalDonations} entries
      </div>


<div style="display: flex; justify-content: flex-end;">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:choose>
                <c:when test="${isSearch}">
                    <li class="page-item active">
                        <a class="page-link" href="#">1</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <c:if test="${totalPages > 1}">
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="/user_donation?id=${id}&page=${i}&pageSize=${pageSize}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
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
</script>

</body>
</html>
