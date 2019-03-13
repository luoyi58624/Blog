package com.ly666.service;import com.github.pagehelper.PageInfo;import com.ly666.entity.Category;import java.util.List;/** * @author ：luoyi * @date ：Created in 2019/3/4 10:24 * @desc : {} */public interface CategoryService {	/*	* 添加分类	* */	void addCategory(Category category) throws Exception;	/*	* 获取所有分类数据并分页展示	* */	PageInfo<Category> queryAllCategory(Integer pageNum, Integer pageSize);	/*	* 获取指定cid的分类数据	* */	Category getCategory(Integer cid);	/*	* 跟新指定cid的分类数据	* */	void update(Category category) throws Exception;	/*	* 删除指定cid的分类数据	* */	void delete(Integer cid);	/*	* 根据parentid获取相应的分类数据	* */	List<Category> getParentCategory(Integer parentid);	/*	 * 检验接收的分类数据	 * */	Boolean checkCategory(Category category) throws Exception;	/*	* 获取指定分类名的数据	* */	Category getCnameCategory(String cname);}