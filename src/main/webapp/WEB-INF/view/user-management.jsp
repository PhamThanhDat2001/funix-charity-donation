<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="../resources/css/user-manage.css">

    <style>
       .readonly-input {
                  background-color: #f0f0f0;
                  cursor: not-allowed;
              }
    </style>
</head>
<body>

<div class="main-content">
    <button onclick="clearModal()" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable">
        Thêm mới
    </button>

    <div style="display:flex; justify-content:space-between;">
        <form action="/user/admin" method="get">
            <div class="form-group">
                <label for="pageSize">Kích thước trang</label>
                <select name="size" id="pageSize" class="form-control" onchange="this.form.submit()">
                    <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                    <option value="15" ${pageSize == 15 ? 'selected' : ''}>15</option>
                </select>
            </div>

        </form>
       <div class="search-container">
           <form action="/user/admin" method="get" class="form-inline">
               <div class="input-group">
                   <input type="text" class="form-control" name="phoneNumber" placeholder="Tìm kiếm email, sdt" aria-label="Tìm kiếm theo số điện thoại..." aria-describedby="button-addon2">
                   <div class="input-group-append">
                       <button class="btn btn-primary" type="submit" id="button-addon2">Tìm kiếm</button>
                   </div>
               </div>
           </form>
       </div>


    </div>

    <table class="table">
        <thead>
            <tr>
                <th scope="col">Họ tên</th>
                <th scope="col">Email</th>
                <th scope="col">Số điện thoại</th>
                <th scope="col">Tài khoản</th>
                <th scope="col">Vai trò</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.fullName}</td>
                    <td>${user.email}</td>
                    <td>${user.phoneNumber}</td>
                    <td>${user.userName}</td>
                    <td>${user.role.roleName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${user.status == 1}">
                                <span style="color: green;">Hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: red;">Đã khóa</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                   <td>

                       <button type="button" class="btn btn-success">Gửi</button>

                        <button type="button" class="btn btn-primary" onclick="editUser(${user.id}, '${user.fullName}', '${user.email}', '${user.phoneNumber}', '${user.userName}', '${user.role.id}', '${user.address}', '${user.password}','${user.status}')">Sửa</button>
                       <button type="button" class="btn btn-warning" onclick="showUser(${user.id}, '${user.fullName}', '${user.email}', '${user.phoneNumber}', '${user.userName}', '${user.role.id}', '${user.address}', '${user.password}','${user.note}','${user.status}','${user.created}')">Chi tiết</button>

                       <br>
                       <c:if test="${user.status != 1}">
                           <form action="/user/unlock" method="post" style="display:inline;">
                               <input type="hidden" name="userId" value="${user.id}">
                               <button type="submit" class="btn btn-info">Mở</button>
                           </form>
                       </c:if>
                           <a href="/user/delete?userId=${user.id}" class="btn btn-danger" data="${user.fullName}" onclick="return confirmDelete(event, this)">Xóa</a>
                       <c:if test="${user.status == 1}">
                           <form action="/user/lock" method="post" style="display:inline;">
                               <input type="hidden" name="userId" value="${user.id}">
                               <button type="submit" class="btn btn-danger">Khóa</button>
                           </form>
                       </c:if>
                   </td>

                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="dataTables_info" id="example_info" role="status" aria-live="polite">
        Showing ${startEntry} to ${endEntry} of ${totalUsers} entries
    </div>


    <!-- Phần phân trang sẽ được ẩn khi có phoneNumber -->
    <c:if test="${empty searchedPhoneNumber}">
        <ul class="pagination">
            <c:forEach begin="0" end="${(totalUsers - 1) >= 0 ? (totalUsers - 1) / pageSize : 0}" varStatus="status">
                <li class="page-item ${status.index == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${status.index}&size=${pageSize}">${status.index + 1}</a>
                </li>
            </c:forEach>
        </ul>
    </c:if>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalScrollableTitle">Người dùng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form action="admin" modelAttribute="user" method="POST">
                    <table>
                        <tbody>
                            <!-- Hidden input field for 'id' -->
                                <form:hidden path="id" />
                            <tr>
                                <td><label>Họ và tên:</label></td>
                                <td><form:input path="fullName" required="true" /></td>
                            </tr>
                            <tr>
                                <td><label>Số điện thoại:</label></td>
                                <td><form:input path="phoneNumber" required="true"/></td>
                            </tr>
                            <tr>
                                <td><label>Tài khoản:</label></td>
                                <td><form:input  path="userName" required="true"/></td>
                            </tr>
                            <tr>
                                <td><label id="vaitro">Vai trò:</label></td>
                                <td >
                                    <form:select id="roleI" path="role.id" class="form-control">
                                        <form:option value="2">User</form:option>
                                        <form:option value="1">Admin</form:option>
                                    </form:select>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Email:</label></td>
                                <td><form:input type="email" path="email" required="true" /></td>
                            </tr>
                            <tr>
                                <td><label>Địa chỉ:</label></td>
                                <td><form:input path="address"  required="true" /></td>
                            </tr>

                            <tr id="passwordField">
                                <td><label>Mật khẩu:</label></td>
                                <td><form:input type="password" path="password" required="true"/></td>
                            </tr>

                            <hr>
                         <tr>
                             <td colspan="2" class="text-right" id="bt">
                                 <button type="button" class="btn btn-secondary mr-2" data-dismiss="modal">Đóng</button>
                                 <input type="submit" value="Save" class="save btn btn-primary" />
                             </td>
                         </tr>
                             <tr >
                                <td><label id="ghichu">Ghi chú:</label></td>
                                <td><form:input id="note2" path="note" value="account" /></td>
                            </tr>
                            <tr >
                                <td><label id="trangthai">Trạng thái:</label></td>
                                <td><form:input id="status2" path="status" value="1" /></td>
                            </tr>
                            <tr >
                                <td><label id="ngaytao">Ngày tạo:</label></td>
                                <td><form:input id="created2" path="created" value="${now}"/></td>
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
     const userFullName = element.getAttribute('data');
     Swal.fire({
         title: "Bạn chắc chắn muốn xóa người dùng " + userFullName + "?",
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



<!-- JavaScript dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script>
    // Function to clear modal content before opening
       function clearModal() {
              $('#id').val(0);
           $('#fullName').val('').prop('readonly', false).removeClass('readonly-input');
           $('#email').val('').prop('readonly', false).removeClass('readonly-input');
           $('#phoneNumber').val('').prop('readonly', false).removeClass('readonly-input');
           $('#userName').val('').prop('readonly', false).removeClass('readonly-input');
           $('#roleId').val('').prop('readonly', false).removeClass('readonly-input');
           $('#address').val('').prop('readonly', false).removeClass('readonly-input');
           $('#password').val('').prop('readonly', false).removeClass('readonly-input');
           $('#passwordField').show(); // Hiển thị trường password
            $('#note').hide();
             $('#status').hide();
              $('#created').hide();
            $('#note2').hide();
             $('#status2').hide();
              $('#created2').hide();
              $('#ghichu').hide();
              $('#trangthai').hide();
              $('#ngaytao').hide();
               $('#vaitro').show();
                $('#roleI').show();
              $('#bt').show();
       }


    // Function to edit user
    function editUser(id, fullName, email, phoneNumber, userName, roleId, address, password,status) {
        // Đổ dữ liệu vào các trường input của modal sửa

        $('#id').val(id);
        $('#fullName').val(fullName).prop('readonly', false).removeClass('readonly-input');
        $('#email').val(email).prop('readonly', true).addClass('readonly-input'); // readonly không được sửa
        $('#phoneNumber').val(phoneNumber).prop('readonly', false).removeClass('readonly-input');
        $('#userName').val(userName).prop('readonly', true).addClass('readonly-input'); // readonly không được sửa
        $('#roleId').val(roleId).prop('readonly', false).removeClass('readonly-input');
        $('#address').val(address).prop('readonly', false).removeClass('readonly-input');
        $('#password').val(password).prop('readonly', false).removeClass('readonly-input');
        $('#status2').val(status).show().prop('readonly', true).addClass('readonly-input');
        // Ẩn trường Password
        $('#passwordField').hide();
        $('#note').hide();
        $('#status').hide();
        $('#created').hide();
        $('#note2').hide();
        $('#status2').hide();
        $('#created2').hide();
        $('#ghichu').hide();
        $('#trangthai').hide();
        $('#ngaytao').hide();
         $('#vaitro').show();
         $('#roleI').show();
        $('#bt').show();
        // Đổi class của các trường input khi sửa để tương thích với CSS
        $('#exampleModalScrollable').modal('show');

    }

       function showUser(id, fullName, email, phoneNumber, userName, roleId, address, password,note,status,created) {
            // Đổ dữ liệu vào các trường input của modal sửa

            $('#id').val(id);
            $('#fullName').val(fullName).prop('readonly', true).addClass('readonly-input');
            $('#email').val(email).prop('readonly', true).addClass('readonly-input');
            $('#phoneNumber').val(phoneNumber).prop('readonly', true).addClass('readonly-input');
            $('#userName').val(userName).prop('readonly', true).addClass('readonly-input');
            $('#roleI').hide();
            $('#vaitro').hide();
            $('#address').val(address).prop('readonly', true).addClass('readonly-input');
            $('#password').val(password);
            // Ẩn trường Password
            $('#passwordField').hide();
            $('#note').val(note).show().prop('readonly', true).addClass('readonly-input');
            $('#status').val(status).show().prop('readonly', true).addClass('readonly-input');
            $('#created').val(created).show().prop('readonly', true).addClass('readonly-input');
            $('#note2').val(note).show().prop('readonly', true).addClass('readonly-input');
            // Hiển thị trạng thái dưới dạng text
            if (status == 0) {
           $('#status2').val('Đã khóa').prop('readonly', true).addClass('readonly-input');
            } else if (status == 1) {
                $('#status2').val('Hoạt động').prop('readonly', true).addClass('readonly-input');
             } else {
                 $('#status2').val(status).prop('readonly', true).addClass('readonly-input');
              } $('#created2').val(created).show().prop('readonly', true).addClass('readonly-input');
             $('#ghichu').val(note).show().prop('readonly', true);
            $('#trangthai').val(status).show().prop('readonly', true);
             $('#ngaytao').val(created).show().prop('readonly', true);
            $('#bt').hide();
            // Đổi class của các trường input khi sửa để tương thích với CSS
            $('#exampleModalScrollable').modal('show');
        }

</script>

</body>
</html>
