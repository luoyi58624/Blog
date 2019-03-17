package com.ly666.controller.mgrAdmin;import com.github.pagehelper.PageInfo;import com.ly666.entity.Article;import com.ly666.entity.Category;import com.ly666.service.ArticleService;import com.ly666.service.CategoryService;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.PathVariable;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RequestMethod;import org.springframework.web.bind.annotation.RequestParam;import org.springframework.web.multipart.MultipartFile;import javax.annotation.Resource;import javax.servlet.ServletContext;import javax.servlet.http.HttpSession;import java.io.File;import java.io.IOException;import java.util.Map;/** * @author ：luoyi * @date ：Created in 2019/3/4 21:59 * @desc : {} */@Controller@RequestMapping("/article")public class ArticalAction {	@Resource(name = "ArticelServiceImpl")	ArticleService articleService;	@Resource(name = "CategoryServiceImpl")	CategoryService categoryService;	@RequestMapping(value = "/mgrMain/{pageNum}", method = RequestMethod.GET)	public String mgrMain(@PathVariable Integer pageNum, Model model) {		Integer pageSize = 9;		PageInfo<Article> pageArticle = articleService.getPageArticle(pageNum, pageSize);		model.addAttribute("ArticlePageNum", pageNum);		model.addAttribute("ArticlePages", pageArticle.getPages());		model.addAttribute("ArticleTotal", pageArticle.getTotal());		model.addAttribute("CurrentArticle", pageArticle.getList());		return "/bk_admin/mgr_main.jsp";	}	@RequestMapping("articleUpload/{DML}")	public String articleUpload(@RequestParam("picture") MultipartFile picture, @PathVariable String DML, Article article, HttpSession session, Model model) {		boolean bool = false;		//获取上传的图片名		String pictureName = picture.getOriginalFilename();		//设置上传的图片名字		article.setArticlePic(pictureName);		//如果DML是add,则进行添加操作		if ("add".equals(DML))			bool = articleService.addArticle(article);		//如果DML是update,则进行更新操作		if ("update".equals(DML))			bool = articleService.updateArticle(article);		//如果数据插入成功，则开始进行图片的上传，并且重定向到主页		if (bool) {			//判断图片名是否为空			if (!"".equals(picture.getOriginalFilename())) {				//获取上传路径				ServletContext servletContext = session.getServletContext();				String picturePath = servletContext.getRealPath("/static_resource/upload");				//拼接路径与图片名组成完整路径				String uploadPath = picturePath + "/" + pictureName;				try {					//开始上传文件					picture.transferTo(new File(uploadPath));				} catch (IOException e) {					e.printStackTrace();				}			}			return "redirect:/article/mgrMain/1";		}		model.addAttribute("addArticleErr", "error");		return "/bk_admin/mgr_add_article.jsp";	}	@RequestMapping("getArticle/{article_id}")	public String getArticle(@PathVariable Integer article_id, Map<String, Object> map) {		Article article = articleService.getArticle(article_id);		Category category = categoryService.getCategory(article.getArticleCid());		map.put("article", article);		map.put("category", category);		return "/bk_admin/mgr_edit_article.jsp";	}	@RequestMapping("getLikeArticle/{pageNum}")	public String getLikeArticle(@PathVariable Integer pageNum, String article_title, Model model) {		Integer pageSize = 9;		PageInfo<Article> likeArticles = articleService.getLikeArticles(pageNum, pageSize, article_title);		model.addAttribute("ArticlePageNum", pageNum);		model.addAttribute("ArticlePages", likeArticles.getPages());		model.addAttribute("ArticleTotal", likeArticles.getTotal());		model.addAttribute("CurrentArticle", likeArticles.getList());		return "/bk_admin/mgr_main.jsp";	}	@RequestMapping("deleteArticle/{article_cid}")	public String deleteArticle(@PathVariable Integer article_cid) {		articleService.deleteArticle(article_cid);		return "redirect:/article/mgrMain/1";	}}