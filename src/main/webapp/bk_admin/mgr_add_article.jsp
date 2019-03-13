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
	<link rel="stylesheet" href="${ctx }/static_resource/css/style.css" type="text/css"/>
	<link rel="stylesheet" href="${ctx }/static_resource/css/amazeui.min.css"/>
	<script type="text/javascript" charset="utf-8" src="${ctx }/static_resource/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${ctx }/static_resource/ueditor/ueditor.all.min.js"> </script>
	<script type="text/javascript" charset="utf-8" src="${ctx }/static_resource/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script src="${ctx }/static_resource/js/jquery.min.js"></script>
	<style>
		.update_pic{
			margin-bottom: 150px;
		}
		#imageview{
			width: 300px;
			height: 180px;
		}
	</style>
</head>
<body>


<div class="main_top">
	<div class="am-cf am-padding am-padding-bottom-0">
		<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">添加文章
		</strong>
			<small></small>
		</div>
	</div>
	<hr>
	<form id="blog_form" action="${ctx}/article/articleUpload/add" method=post enctype="multipart/form-data">
		<div class="edit_content">
			<div class="item1">
				<div>
					<span>文章标题：</span>
					<input type="text" id="articleTitle" class="am-form-field" name="articleTitle" style="width: 300px"> <span id="checkArticleTitle"></span>
				</div>
			</div>

			<input type="text" name="articleDesc" id="article_desc" style="display: none;">
			<div class="item1">
				<span>所属分类：</span>
				<select id="category_select" name="cid" style="width: 150px">&nbsp;&nbsp;</select>
				<select id="skill_select" name="articleCid" style="width: 150px">&nbsp;&nbsp;</select>
			</div>

			<div class="item1 update_pic">
				<span>摘要图片：</span>
				<img src="" id="imageview" class="item1_img" style="display: none;">
				<label for="fileupload" id="label_file">上传文件</label>
				<input type="file" name="picture" id="fileupload"/>
			</div>
			<div id="editor" name="articleContent" style="width:900px;height:400px;"></div>

			<button class="am-btn am-btn-default" type="button" id="send" style="margin-top: 10px;">
				发布
			</button>
		</div>
	</form>
</div>
<script type="text/javascript">
	$(function () {
		var ue=UE.getEditor("editor");
		var category_select=$("#category_select");
		var skill_select=$("#skill_select");
		//ajax获取分类数据
		$.post("${ctx}/jsonCategoryArticle/jsonParentCategory/0", function (data) {
			for (var i = 0; i < data.length; i++) {
				category_select.append("<option value="+data[i].cid+">" + data[i].cname + "</option>")
			}
			//直接触发事件，ajax继续返回子结果
			category_select.trigger("change");
		});
		category_select.on("change",function () {
			var cid=category_select.val();
			$.post("${ctx}/jsonCategoryArticle/jsonParentCategory/"+cid,function (data) {
				//先清空标签，再将新的标签添加上来
				skill_select.empty();
				for (var i = 0; i < data.length; i++) {
					skill_select.append("<option value=" + data[i].cid + ">" + data[i].cname + "</option>")
				}
			})
		});
		/*原理是把本地图片路径："D(盘符):/image/..."转为"http://..."格式路径来进行显示图片*/
		$("#fileupload").change(function() {
			var $file = $(this);
			var objUrl = $file[0].files[0];
			//获得一个http格式的url路径:mozilla(firefox)||webkit or chrome
			var windowURL = window.URL || window.webkitURL;
			//createObjectURL创建一个指向该参数对象(图片)的URL
			var dataURL;
			dataURL = windowURL.createObjectURL(objUrl);
			var imageview=$("#imageview");
			imageview.attr("src",dataURL);
			console.log(imageview.attr('style'));
			if(imageview.attr('style') === 'display: none;'){
				imageview.attr('style','inline');
				imageview.width("300px");
				imageview.height("200px");
				imageview.attr('style', 'margin-bottom: 80px;');
			}
		});
		$("#articleTitle").on("blur",function () {
			if($(this).val()===""){
				$("#checkArticleTitle").text("文章标题不能为空").css({"color":"red","font-size":"14px"});
			}
		});
		$("#send").click(function () {
			//设置文本的描述
			//获取富文本正文
			var text = ue.getContentTxt();
			//设置正文
			text = text.substring(0,150)+"...";
			//设置描述
			$("#article_desc").val(text);
			$("#blog_form").submit();
		});
		<c:if test="${!empty addArticleErr}">
		alert("文章发布失败，请检查文章内容");
		</c:if>
	});
</script>
</body>
</html>