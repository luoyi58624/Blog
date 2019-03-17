<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html dir="ltr" lang="en-US">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>博客后台管理系统</title>
	<link href="/favicon.ico" rel="shortcut icon">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resource/css/style.css" type="text/css"/>
	<style>
	</style>
</head>

<body>
<div id="container">

	<form action="${pageContext.request.contextPath}/login" id="login_form" method="post">
		<div class="login">博客后台管理系统
			<span style="color:red"><c:if test="${!empty error}">用户名或密码不正确</c:if></span>
		</div>
		<div class="username-text">用户名:</div>
		<div class="password-text">密码:</div>
		<div class="username-field">
			<input type="text" name="adminName" id="admin_name" autocomplete="off"/>
		</div>
		<div class="password-field">
			<input type="password" name="adminPwd" id="admin_pwd"/>
		</div>
		<input type="checkbox" name="remember" value="true" id="remember-me"/>
		<label for="remember-me">记住用户名</label>
		<div class="forgot-usr-pwd"></div>
		<input type="submit" name="submit" value="登录" style="font-size: 16px;margin-top:
				-1px;"/>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static_resource/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function () {
		$.post("${pageContext.request.contextPath}/checkAdminCookie", function (data) {
			console.log(data);
			if(admin_name!=null){
				$("#admin_name").val(data.admin_name);
				$("#admin_pwd").val(data.admin_pwd);
				$("#remember-me").attr("checked",true);
			}
		});
	});
</script>

</body>
</html>
