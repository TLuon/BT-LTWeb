<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt lại mật khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-info text-white text-center">
                    <h4>Đặt Lại Mật Khẩu</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <p class="text-muted text-center">Vui lòng kiểm tra email <b>${sessionScope.reset_email}</b> để lấy mã OTP.</p>
                    <form action="${pageContext.request.contextPath}/reset" method="post">
                        <div class="mb-3">
                            <label>Mã OTP</label>
                            <input type="text" name="otp" class="form-control" required placeholder="Nhập 6 số OTP">
                        </div>
                        <div class="mb-3">
                            <label>Mật khẩu mới</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-info w-100 text-white">Đặt lại mật khẩu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
