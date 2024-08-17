<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="../resources/css/manage-donation.css">
        <link rel="stylesheet" href="../resources/css/sidebar.css">
        <style>
      .action-buttons {
          text-align: center; /* Căn giữa nội dung trong cột */
      }

      .action-buttons button,
      .action-buttons a.btn {
          margin: 5px; /* Khoảng cách giữa các nút */
      }

      .action-buttons form {
          display: inline; /* Hiển thị form như một dòng liền kề */
          margin: 0;
      }
   .readonly-input {
                  background-color: #f0f0f0;
                  cursor: not-allowed;
              }
        </style>
<script>
            function showContent(contentId) {
                var contents = document.querySelectorAll('.content');
                contents.forEach(function(content) {
                    content.classList.remove('active');
                });
                var selectedContent = document.getElementById(contentId);
                selectedContent.classList.add('active');
            }
             function navigateToDonateAdmin() {
              window.location.href = '/donation/admin';
                     }

             function navigateToUserAdmin() {
              window.location.href = '/user/admin';
                     }
             function navigateToHome() {
               window.location.href = '/user_donation/home';
               }
         function navigateToPage(page, size) {
             window.location.href = '/donation/admin?page=' + page + '&size=' + size;

         }

         function updatePageSize() {
             var size = document.getElementById("pageSizeSelect").value;
             navigateToPage(1, size);
         }

        </script>
</head>
<body>
<div class="main-content">
    <button onclick="clearModal2()" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable">
        Thêm mới
    </button>
   <div class="container">
        <div class="sidebar">
            <button onclick="navigateToUserAdmin()">User Management</button>
            <button onclick="navigateToDonateAdmin()">Manage Donate</button>
            <button onclick="navigateToHome()">Trang chủ</button>
        </div>
        <div class="main-content">

        </div>
    </div>

        <div class="page-size">
                <label for="pageSizeSelect">Kích thước trang:</label>
                <select id="pageSizeSelect" class="form-control" style="width: auto; display: inline-block;" onchange="updatePageSize()">
                    <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                    <option value="15" ${pageSize == 15 ? 'selected' : ''}>15</option>
                </select>
            </div>

  <div class="search-container">
           <form action="/donation/admin" method="get" class="form-inline">
               <div class="input-group">
                   <input type="text" class="form-control" name="search" placeholder="Tìm kiếm " aria-label="Tìm kiếm theo số điện thoại..." aria-describedby="button-addon2">
                   <div class="input-group-append">
                       <button class="btn btn-primary" type="submit" id="button-addon2">Tìm kiếm</button>
                   </div>
               </div>
           </form>
       </div>


 <table class="table">
        <thead>
            <tr>
                <th scope="col">Mã</th>
                <th scope="col">Tên</th>
                <th scope="col">Ngày bắt đầu</th>
                <th scope="col">Ngày kết thúc</th>
                <th scope="col">Tổ chức</th>
                <th scope="col">Số điện thoại</th>
                <th scope="col">Tổng tiền</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="donation" items="${donations}">
                <tr>
                    <td>${donation.code}</td>
                    <td>${donation.name}</td>
                    <td>${donation.startDate}</td>
                    <td>${donation.endDate}</td>
                    <td>${donation.organizationName}</td>
                    <td>${donation.phoneNumber}</td>
                    <td>${donation.money} VND</td>
                    <td>
                        <%-- Sử dụng JSP Expression để hiển thị giá trị status --%>
                        <c:choose>
                            <c:when test="${donation.status == 0}">
                                Mới tạo
                            </c:when>
                            <c:when test="${donation.status == 1}">
                                Đang quyên góp
                            </c:when>
                            <c:when test="${donation.status == 2}">
                                Kết thúc quyên góp
                            </c:when>
                            <c:otherwise>
                                Đóng quyên góp
                            </c:otherwise>
                        </c:choose>
                    </td>

                   <td class="action-buttons">
                 <c:choose>
                     <c:when test="${donation.status == '0'}">
                         <button type="button" class="btn btn-primary" onclick="editDonation(${donation.id}, '${donation.code}', '${donation.startDate}', '${donation.organizationName}', '${donation.description}', '${donation.name}', '${donation.endDate}', '${donation.phoneNumber}', '${donation.money}', '${donation.status}')">Cập nhật</button>
                         <button type="button" class="btn btn-warning" onclick="showDonation(${donation.id})">Chi tiết</button>
                         <a href="/donation/delete?donationId=${donation.id}" class="btn btn-danger" data="${donation.name}" onclick="return confirmDelete(event, this)">Xóa</a>
                         <form action="/donation/donate" method="post">
                             <input type="hidden" name="donationId" value="${donation.id}">
                             <button type="submit" class="btn btn-success">Quyên góp</button>
                         </form>
                     </c:when>
                     <c:when test="${donation.status == '1'}">
                         <button type="button" class="btn btn-primary" onclick="editDonation(${donation.id}, '${donation.code}', '${donation.startDate}', '${donation.organizationName}', '${donation.description}', '${donation.name}', '${donation.endDate}', '${donation.phoneNumber}', '${donation.money}', '${donation.status}')">Cập nhật</button>
                         <button type="button" class="btn btn-warning" onclick="showDonation(${donation.id})">Chi tiết</button>
                         <form action="/donation/end" method="post">
                             <input type="hidden" name="donationId" value="${donation.id}">
                             <button type="submit" class="btn btn-success">Kết thúc</button>
                         </form>
                     </c:when>
                     <c:when test="${donation.status == '2'}">
                         <form action="/donation/close" method="post">
                             <input type="hidden" name="donationId" value="${donation.id}">
                             <button type="submit" class="btn btn-success">Đóng</button>
                         </form>
                         <button type="button" class="btn btn-warning" onclick="showDonation(${donation.id})">Chi tiết</button>
                         <a href="/donation/delete?donationId=${donation.id}" class="btn btn-danger" data="${donation.name}" onclick="return confirmDelete(event, this)">Xóa</a>
                     </c:when>
                     <c:otherwise>
                         <button type="button" class="btn btn-warning" onclick="showDonation(${donation.id})">Chi tiết</button>
                         <a href="/donation/delete?donationId=${donation.id}" class="btn btn-danger" data="${donation.name}" onclick="return confirmDelete(event, this)">Xóa</a>
                     </c:otherwise>
                 </c:choose>
                   </td>

                </tr>
            </c:forEach>
        </tbody>
    </table>
       <div class="dataTables_info" id="example_info" role="status" aria-live="polite">
            Showing ${startEntry} to ${endEntry} of ${totalDonations} entries
        </div>

  <!-- Phần phân trang sẽ được ẩn khi có giá trị tìm kiếm -->
    <c:if test="${empty search}">
        <div class="pagination">
            <c:forEach begin="1" end="${totalPages}" var="page">
                <button type="button" class="btn btn-secondary page-link" onclick="navigateToPage(${page}, ${pageSize})">${page}</button>
            </c:forEach>
        </div>
    </c:if>



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
                <form:form action="admin" modelAttribute="donation" method="POST">
                    <table>
                        <tbody>
                            <!-- Hidden input field for 'id' -->
                                <form:hidden path="id" />
                            <tr>
                                <td><label>Mã đợt quyên góp:</label></td>
                                <td><form:input path="code" required="true" /></td>
                            </tr>
                            <tr>
                                <td><label>Ngày bắt đầu:</label></td>
                                <td><form:input type="date" path="startDate" required="true"/></td>
                            </tr>
                            <tr>
                                 <td><label>Tổ chức:</label></td>
                                <td><form:input  path="organizationName" required="true"/></td>
                            </tr>

                            <tr>
                                <td><label>Tên đợt khuyên góp:</label></td>
                                <td><form:input  path="name" required="true" /></td>
                            </tr>
                            <tr>
                                <td><label>Ngày kết thúc:</label></td>
                                <td><form:input type="date" path="endDate"  required="true" /></td>
                            </tr>

                            <tr >
                                <td><label>Số điện thoại:</label></td>
                                <td><form:input path="phoneNumber" required="true"/></td>
                            </tr>
                            <tr>
                                <td><label>Nội dung:</label></td>
                                <td><form:input  path="description" required="true" /></td>
                            </tr>
                            <tr>
                                <td><label id="tongtien">Tổng tiền quyên góp:</label></td>
                                <td><form:input  path="money" required="true" /></td>
                            </tr>
                            <tr>
                                <td><label id="trangthai">Trạng thái:</label></td>
                                <td><form:input  path="status" required="true" /></td>
                            </tr>
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



<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 <script>
 function confirmDelete(event, element) {
     event.preventDefault(); // Ngăn chặn hành động mặc định của liên kết
     const nameDonation = element.getAttribute('data');
     Swal.fire({
         title: "Bạn chắc chắn muốn xóa đợt khuyên góp: " + nameDonation + "?",
         text: "Hành động này không thể được hoàn tác!",
         icon: 'warning',
         showCancelButton: true,
         confirmButtonColor: '#3085d6',
         cancelButtonColor: '#d33',
         confirmButtonText: 'Xóa',
         cancelButtonText: 'Đóng'
     }).then((result) => {
         if (result.isConfirmed) {
             window.location.href = element.href;
         }
     });
     return false;
 }
 </script>


    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script>

   function clearModal2() {
         $('#id').val(0).prop('readonly', false).removeClass('readonly-input');
         $('#code').val('').prop('readonly', false).removeClass('readonly-input');
         $('#startDate').val('').prop('readonly', false).removeClass('readonly-input');
         $('#organizationName').val('').prop('readonly', false).removeClass('readonly-input');
         $('#description').val('').prop('readonly', false).removeClass('readonly-input');
         $('#name').val('').prop('readonly', false).removeClass('readonly-input');
         $('#endDate').val('').prop('readonly', false).removeClass('readonly-input');
         $('#phoneNumber').val('').prop('readonly', false).removeClass('readonly-input');
         $('#money').val(0).hide();
         $('#status').val(0).hide();
         $('#tongtien').hide();
         $('#trangthai').hide();
          $('#bt').show();
         // Đổi class của các trường input khi sửa để tương thích với CSS
         $('#exampleModalScrollable').modal('show');
       }



    // Function to edit
    function editDonation(id, code, startDate, organizationName, description, name, endDate, phoneNumber,money,status) {
        // Đổ dữ liệu vào các trường input của modal sửa

        $('#id').val(id).prop('readonly', false).removeClass('readonly-input');
        $('#code').val(code).prop('readonly', false).removeClass('readonly-input');
        $('#startDate').val(startDate).prop('readonly', false).removeClass('readonly-input');
        $('#organizationName').val(organizationName).prop('readonly', false).removeClass('readonly-input');
        $('#description').val(description).prop('readonly', false).removeClass('readonly-input');
        $('#name').val(name).prop('readonly', false).removeClass('readonly-input');
        $('#endDate').val(endDate).prop('readonly', false).removeClass('readonly-input');
        $('#phoneNumber').val(phoneNumber).prop('readonly', false).removeClass('readonly-input');
        $('#money').val(money).hide();
        $('#status').val(status).hide();
        $('#tongtien').hide();
         $('#trangthai').hide();
          $('#bt').show();
        // Đổi class của các trường input khi sửa để tương thích với CSS
        $('#exampleModalScrollable').modal('show');
    }

function showDonation(id) {

    // Chuyển hướng sang trang detail.jsp với các tham số truyền vào
    window.location.href = '/user_donation?id=' + id;
}

</script>
</body>
</html>