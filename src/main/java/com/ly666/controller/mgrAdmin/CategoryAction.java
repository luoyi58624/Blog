package com.ly666.controller.mgrAdmin;import com.github.pagehelper.PageInfo;import com.ly666.entity.Category;import com.ly666.service.CategoryService;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.PathVariable;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RequestParam;import org.springframework.web.bind.annotation.ResponseBody;import org.springframework.web.servlet.mvc.support.RedirectAttributes;import javax.annotation.Resource;/** * @author ：luoyi * @date ：Created in 2019/3/4 9:36 * @desc : {} */@Controller@RequestMapping("/category")public class CategoryAction {	@Resource(name = "CategoryServiceImpl")	private CategoryService categoryService;	@RequestMapping("addCategory")	public String addCategory(Category category, RedirectAttributes attr) {		try {			categoryService.addCategory(category);		} catch (Exception e) {			attr.addAttribute("message", e.getMessage());		}		return "redirect:/category/allCategory/1";	}	/*	 * @pageNum 当前页码	 * @pageSize 一页多少条数据	 * @pages 总页数	 * @total 总记录数	 * */	@RequestMapping("allCategory/{pageNum}")	public String allCategory(@PathVariable Integer pageNum,	                          @RequestParam(value = "message", required = false) String message,	                          Model model) {		Integer pageSize = 9;		PageInfo<Category> categories = categoryService.queryAllCategory(pageNum, pageSize);		model.addAttribute("CategoryPageNum", pageNum);		model.addAttribute("CategoryPages", categories.getPages());		model.addAttribute("CategoryTotal", categories.getTotal());		model.addAttribute("CategoryCurrentCategory", categories.getList());		model.addAttribute("message",message);		return "/bk_admin/mgr_category.jsp";	}	@RequestMapping("findCurrentCategory/{cid}")	@ResponseBody	public Category getCategory(@PathVariable Integer cid) {		return categoryService.getCategory(cid);	}	@RequestMapping("updateCategory")	public String updateCategory(Category category, RedirectAttributes attr) {		try {			categoryService.update(category);		} catch (Exception e) {			attr.addAttribute("message", e.getMessage());		}		return "redirect:/category/allCategory/1";	}	@RequestMapping("deleteCategory/{cid}")	public String deleteCategory(@PathVariable Integer cid) {		categoryService.delete(cid);		return "redirect:/category/allCategory/1";	}}