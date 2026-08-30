<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h4>Đăng Nhập</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <c:if test="${param.msg == 'active_success'}">
                        <div class="alert alert-success">Kích hoạt tài khoản thành công. Vui lòng đăng nhập!</div>
                    </c:if>
                    <c:if test="${param.msg == 'reset_success'}">
                        <div class="alert alert-success">Đặt lại mật khẩu thành công. Vui lòng đăng nhập!</div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Mật khẩu</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                    </form>
                </div>
                <div class="card-footer text-center">
                    <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a> | 
                    <a href="${pageContext.request.contextPath}/forgot">Quên mật khẩu?</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
