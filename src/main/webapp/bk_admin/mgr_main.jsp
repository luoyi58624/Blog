<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctx = request.getContextPath();
	pageContext.setAttribute("ctx", ctx);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	<link rel="stylesheet" href="${ctx }/static_resource/css/style.css"
	      type="text/css"/>
	<link rel="stylesheet" href="${ctx }/static_resource/css/amazeui.min.css"/>
	<link rel="stylesheet" href="${ctx }/static_resource/css/pageStyle.css">

</head>
<body style="background:#f3f3f3;">

<div class="main_top">
	<div class="am-cf am-padding am-padding-bottom-0">
		<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">文章管理
		</strong>
			<small></small>
		</div>
	</div>
	<hr>
	<div class="am-g">
		<div class="am-u-sm-12 am-u-md-6">
			<div class="am-btn-toolbar">
				<div class="am-btn-group am-btn-group-xs">
					<button id="add" class="am-btn am-btn-default">
						<span class="am-icon-plus"></span> 新增
					</button>
				</div>
			</div>
		</div>
		<div class="am-u-sm-12 am-u-md-3">

		</div>
		<div class="am-u-sm-12 am-u-md-3">
			<div class="am-input-group am-input-group-sm">
				<input type="text" class="am-form-field" id="input_search">
				<span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" type="button" id="input_search_btn">搜索</button>
                </span>
			</div>
		</div>
	</div>
</div>

<div class="goods_list">
	<ul class="title_ul">
		<li>序号</li>
		<li>标题</li>
		<li>类别</li>
		<li>编辑</li>
		<li>删除</li>
	</ul>

  <c:forEach items="${CurrentArticle}" var="i">
	<ul class="list_goods_ul">
		<li>${i.articleId}</li>
		<li><c:out value="${i.articleTitle}"/></li>
		<li>${i.category.cname}</li>
		<li>
			<a href="${ctx}/article/getArticle/${i.articleId}">
				<img class="img_icon" src="${ctx }/static_resource/images/edit_icon.png" alt=""></a>
		</li>
		<li>
			<a href="${ctx}/article/deleteArticle/${i.articleId}">
				<img class="img_icon" src="${ctx }/static_resource/images/delete_icon.png" alt="">
			</a>
		</li>
	</ul>
  </c:forEach>
	<!--分页-->
	<div id="page" class="page_div"></div>
</div>

<script src="${ctx}/static_resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static_resource/js/paging.js"></script>
<script>

	//分页
	$("#page").paging({
		pageNo:${ArticlePageNum},
		totalPage: ${ArticlePages},
		totalSize: ${ArticleTotal},
		callback: function (num) {
			window.location.href = "${pageContext.request.contextPath}/article/mgrMain/" + num;
		}
	});

	$("#add").click(function () {
		$(window).attr('location', '${ctx }/bk_admin/mgr_add_article.jsp');
	});
	$("#input_search_btn").click(function () {
		var article_title=$("#input_search").val();
		$(window).attr('location','${ctx}/article/getLikeArticle/1?article_title='+article_title)
	})
</script>

</body>
</html>