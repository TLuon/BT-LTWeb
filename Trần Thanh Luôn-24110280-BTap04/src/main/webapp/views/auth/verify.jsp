<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác thực OTP</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-warning text-dark text-center">
                    <h4>Xác Thực Email (OTP)</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <p class="text-muted text-center">Vui lòng kiểm tra email <b>${sessionScope.verify_email}</b> để lấy mã OTP.</p>
                    <form action="${pageContext.request.contextPath}/verify" method="post">
                        <div class="mb-3">
                            <label>Mã OTP</label>
                            <input type="text" name="otp" class="form-control" required placeholder="Nhập 6 số OTP">
                        </div>
                        <button type="submit" class="btn btn-warning w-100">Xác thực</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
