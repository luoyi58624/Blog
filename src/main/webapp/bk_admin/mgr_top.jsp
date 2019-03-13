<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static_resource/css/common.css">
</head>
<style>
    .admin_top{
        height: 70px;
        background:#283643;;
        text-align: right;
        padding-right: 70px;
        color: white;
        position: relative;
    }

    .admin_top span{
        position: absolute;
        right: 10px;
        top: 30px;

    }
    .admin_top img{
        margin-top: 20px;
    }
    .admin_top .top_left{
        width: 250px;
        height: 70px;
        background:#283643;
        float: left;
        color: white;
        font-weight: bold;
        text-align: center;
        padding-top: 20px;
        font-size: 20px;
    }
    .admin_top .top_left:hover{
	    cursor: pointer;
    }
    .admin_top .top_left:hover{
        background: #000;
    }
    
</style>
<body style="background:blue">

<div class="admin_top">
    <div class="top_left">
        博客系统
    </div>
    <div class="h_top_right">
        <span style="margin-right: 50px">${admin.admin_name}</span>
        <span><a href="${pageContext.request.contextPath}/exit" style="color: lightseagreen" id="user_exit" target="_parent">退出</a></span>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static_resource/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function () {
		$(".top_left:eq(0)").on("click",function () {
			$(window.parent.frames).attr('location',"${pageContext.request.contextPath}/index.jsp");
		})
	});
</script>
</body>
</html>