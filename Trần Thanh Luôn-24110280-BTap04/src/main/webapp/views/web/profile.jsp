<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0"><i class="bi bi-person-lines-fill"></i> User Profile</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/user/profile" method="post" enctype="multipart/form-data">
                    <div class="text-center mb-4">
                        <c:choose>
                            <c:when test="${not empty user.images}">
                                <img src="${pageContext.request.contextPath}/image?fname=${user.images}" class="rounded-circle img-thumbnail" alt="Profile Image" style="width: 150px; height: 150px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <img src="https://ui-avatars.com/api/?name=${user.fullname}&background=random&size=150" class="rounded-circle img-thumbnail" alt="Profile Image">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Username / Email</label>
                        <input type="text" class="form-control" value="${user.email}" disabled>
                        <div class="form-text">Email cannot be changed.</div>
                    </div>

                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-bold">Full Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="fullname" name="fullname" value="${user.fullname}" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label fw-bold">Phone Number</label>
                        <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}">
                    </div>

                    <div class="mb-4">
                        <label for="imageFile" class="form-label fw-bold">Profile Image</label>
                        <input class="form-control" type="file" id="imageFile" name="imageFile" accept="image/*">
                        <div class="form-text">Choose a new image to update your avatar.</div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg"><i class="bi bi-save"></i> Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
