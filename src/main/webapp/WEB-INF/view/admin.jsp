<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Single Page with Sidebar</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
             <link rel="stylesheet" href="../resources/css/admin.css">
        <style>

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
            function navigateToHome() {
              window.location.href = '/user_donation/home';
                     }
        </script>

    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <button onclick="showContent('content1')">User Management</button>
                <button onclick="navigateToDonateAdmin()">Manage Donate</button>
                <button onclick="navigateToHome()">Trang chủ</button>
            </div>
            <div class="main-content">
                <div id="content1" class="content active">
                    <jsp:include page="user-management.jsp" />
                </div>
                <div id="content2" class="content">
                    <jsp:include page="manage-donation.jsp" />
                </div>
            </div>
        </div>
    </body>
    </html>
