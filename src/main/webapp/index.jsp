<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="header.jsp" %>
<%
	String contextPath = request.getContextPath();
	pageContext.setAttribute("ctx", contextPath);
%>
<html>
<body>
<script src="${ctx}/static_resource/js/template.js"></script>
<style>
	.content_item {
		height: 160px;
		position: relative;
	}

	.content_item img {
		position: absolute;
		right: 10px;
		top: 10px;
		width: 250px;
		height: 140px;
	}
</style>
<!-- 内容区 -->
<section class="layout main-wrap  content">
	<section class='col-main'>

		<article class="mainarea" style="display:block;">
			<div class="blog-tab">
				<div class="tab-content" id="tab_content">
				</div>
			</div>
		</article>
		<!--博客社区-->
		<article class="mainarea" style="display:block;">
			<div class="blog-tab">

				<div class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home">

						<div id="lk_blog_list" class="container">
							<div class="row">
								<ul class="blog-list" id="content">
									<%--文章展示区--%>
								</ul>
								<div id="page" class="page_div"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</article>
	</section>
</section>
<footer id="lk_footer">
	<div class="container">
		<div class="footer-top">
			<!--分页-->
		</div>
		<div class="footer-bottom col-sm-offset-2 hidden-sm hidden-xs">
			<ul>
				<li><a href="">学科报名</a></li>
				<li><a href="">师资团队</a></li>
				<li><a href="">线上公开课</a></li>
				<li><a href="">联络我们</a></li>
				<li><a href="">支持我们</a></li>
				<li><a href="">沪ICP备 18026591号-1</a></li>
			</ul>
		</div>
	</div>
</footer>

<%--定义展示文章内容的模板--%>
<script id="mytpl" type="text/html">
	{{each list as value}}
	<li class="content_item">
		<div class="blog-list-left" style="float: left;">
			<div class="main-title">
				<a href="detail.jsp?id={{value.articleId}}">{{value.articleTitle}}</a>
			</div>
			<p class="sub-title" style="width: 600px">{{value.articleDesc}}</p>
			<div class="meta">
				{{value.articleTime | dateFormat:'yyyy-MM-dd y:m:s'}}
			</div>
		</div>
		<img src="${ctx}/static_resource/upload/{{value.articlePic}}" alt="" class="img-rounded" style="width: 200px">
	</li>
	{{/each}}
</script>
<script id="mytpl2" type="text/html">
	<div role="tabpanel" class="tab-pane fade in active" id="tab">
		<%--分类信息--%>
		<div id="lk_blog_two" class="container">
			<div class="row">
				{{each list as value}}
				<button class="btn-tag categroy_small" data-cid="{{value.cid}}">{{value.cname}}</button>
				{{/each}}
			</div>
		</div>
	</div>
</script>
<script>
	//获取当前参数
	function getParams(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) {
			return unescape(r[2]);
		}
		return null;
	}
	var parentid = getParams("cid");
	if (parentid != null) {
		//加载大分类子集标签
		$.post("${ctx}/jsonCategoryArticle/jsonParentCategory/" + parentid, function (data) {
			var html = template('mytpl2', {list: data});
			$("#tab_content").html(html);
		});
		getPage(1,parentid,null);
	}else {
		//分页展示首页数据
		getPage(1,null,null);
	}
	$("body").on("click",".categroy_small",function () {
		var cid=$(this).data("cid");
		getPage(1,null,cid);
	});
	function getPage(pageNum,parentid,cid) {
		$.post("${ctx}/jsonCategoryArticle/jsonArticle/" + pageNum,{"parentid":parentid,"cid":cid}, function (data) {
			var html = template('mytpl', {list: data.list});
			$("#content").html(html);
			//分页
			$("#page").paging({
				pageNo: data.pageNum,
				totalPage: data.pages,
				totalSize: data.total,
				callback: function (num) {
					getPage(num,parentid,cid);
				}
			})
		}, 'json')
	}
	//时间戳转换
	template.helper('dateFormat', function (date, format) {

		date = new Date(date);

		var map = {
			"M": date.getMonth() + 1, //月份
			"d": date.getDate(), //日
			"h": date.getHours(), //小时
			"m": date.getMinutes(), //分
			"s": date.getSeconds(), //秒
			"q": Math.floor((date.getMonth() + 3) / 3), //季度
			"S": date.getMilliseconds() //毫秒
		};
		format = format.replace(/([yMdhmsqS])+/g, function (all, t) {
			var v = map[t];
			if (v !== undefined) {
				if (all.length > 1) {
					v = '0' + v;
					v = v.substr(v.length - 2);
				}
				return v;
			} else if (t === 'y') {
				return (date.getFullYear() + '').substr(4 - all.length);
			}
			return all;
		});
		return format;
	});
</script>
</body>
</html>