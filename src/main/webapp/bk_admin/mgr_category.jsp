<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resource/css/style.css" type="text/css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resource/css/amazeui.min.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resource/css/pageStyle.css">
	<script src="${pageContext.request.contextPath}/static_resource/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/static_resource/js/paging.js"></script>
	<style>
		#modal_content2 {
			padding: 30px 20px;
			width: 400px;
			height: 200px;
			background: white;
			position: fixed;
			left: 50%;
			top: 50%;
			margin-left: -200px;
			margin-top: -100px;
			display: none;
		}

		#close2 {
			position: absolute;
			right: 10px;
			top: 10px;
		}
	</style>
</head>
<body>

<div class="main_top">
	<div class="am-cf am-padding am-padding-bottom-0">
		<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">分类管理</strong>
			<small></small>
		</div>
	</div>
	<hr>
	<div class="am-g">
		<div class="am-u-sm-12 am-u-md-6">
			<div class="am-btn-toolbar">
				<div class="am-btn-group am-btn-group-xs">
					<button id="add" class="am-btn am-btn-default">
						<span class="am-icon-plus"></span> 添加分类
					</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="goods_list" id="account_List">
	<ul class="title_ul">
		<li>id</li>
		<li>分类名称</li>
		<li>parentid</li>
		<li>修改分类</li>
		<li>删除分类</li>
	</ul>

	<c:forEach var="i" items="${CategoryCurrentCategory}">
		<ul class="list_goods_ul">
			<li>${i.cid}</li>
			<li>${i.cname}</li>
			<li>${i.parentid}</li>
			<li><a href="#" class="current_category_update" data-id="${i.cid}"><img class="img_icon"
			                                                                        src="${pageContext.request.contextPath}/static_resource/images/edit_icon.png"
			                                                                        alt=""></a></li>
			<li><a href="${pageContext.request.contextPath}/category/deleteCategory/${i.cid}"><img class="img_icon"
			                                                                              src="${pageContext.request.contextPath}/static_resource/images/delete_icon.png"
			                                                                              alt=""></a></li>
		</ul>
	</c:forEach>
</div>

<!--分页-->
<div id="page" class="page_div"></div>

<%--显示阴影--%>
<div id="modal_view"></div>

<div id="modal_content">
	<div id="close"><img src="${pageContext.request.contextPath}/static_resource/images/delete_icon.png" alt=""></div>
	<div class="edit_content">
		<div class="item1">
			<div>
				<span>添加分类：</span>
			</div>
		</div>
		<div class="item1">
			<div>
				<span>parentid：</span>
				<input type="text" class="am-form-field" id="parentid">&nbsp;&nbsp;
				<br/>
				<span>分类名称：</span>
				<input type="text" class="am-form-field" id="cname">&nbsp;&nbsp;
			</div>
		</div>
		<div class="item1">
			<button class="am-btn am-btn-default" type="button" id="add_category">添加</button>
		</div>

	</div>
</div>

<div id="modal_content2" style="height: 250px; display: none">
	<div id="close2"><img src="${pageContext.request.contextPath}/static_resource/images/delete_icon.png" alt=""></div>
	<div class="edit_content">
		<div class="item1">
			<div>
				<span>修改分类：</span>
			</div>
		</div>
		<div class="item1">
			<div>
				<span>parentid：</span>
				<input type="text" class="am-form-field" id="parentid2">&nbsp;&nbsp;
				<br/>
				<span>分类名称：</span>
				<input type="text" class="am-form-field" id="cname2">&nbsp;&nbsp;
				<br/>
				<input type="hidden" id="cid2">
				<button class="am-btn am-btn-default" type="button" id="updatebtn">修改</button>
			</div>
		</div>

	</div>
</div>

<script>
	$(function () {
		//响应后台错误信息
		<c:if test="${!empty message}">
		alert("${message}");
		</c:if>
		//添加分类
		$('#add').click(function () {
			$("#modal_view").fadeIn();
			$("#modal_content").fadeIn();
		});

		$("#close").click(function () {
			$("#modal_view").fadeOut();
			$("#modal_content").fadeOut();
		});
		$("#add_category").click(function () {
			window.location.href = "${pageContext.request.contextPath}/category/addCategory?cname=" + $("#cname").val() + "&parentid=" + $("#parentid").val();
		})
	});
	//修改分类
	$(".current_category_update").click(function () {
		var id = $(this).data("id");
		//修改分类数据回显
		$.post("${pageContext.request.contextPath}/category/findCurrentCategory/"+id, function (data) {
			$("#parentid2").val(data.parentid);
			$("#cname2").val(data.cname);
			$("#cid2").val(data.cid);
		}, "json");
		$("#modal_view").fadeIn();
		$("#modal_content2").fadeIn();
	});
	$("#close2").click(function () {
		$("#modal_view").fadeOut();
		$("#modal_content2").fadeOut();
	});
	$("#updatebtn").click(function () {
		window.location.href = "${pageContext.request.contextPath}/category/updateCategory?cname=" + $("#cname2").val() + "&parentid=" + $("#parentid2").val() + "&cid=" + $("#cid2").val();
	});
	//分页
	$("#page").paging({
		pageNo:${CategoryPageNum},
		totalPage: ${CategoryPages},
		totalSize: ${CategoryTotal},
		callback: function (num) {
			window.location.href = "${pageContext.request.contextPath}/category/allCategory/" + num;
		}
	});
</script>
</body>
</html>