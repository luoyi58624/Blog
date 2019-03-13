package com.ly666.mapper;import com.ly666.entity.Category;import org.apache.ibatis.annotations.Param;import org.springframework.stereotype.Repository;import java.util.List;/** * @author ：luoyi * @date ：Created in 2019/3/4 10:26 * @desc : {} */@Repository("CategoryMapper")public interface CategoryMapper {	/*	* 添加分类	* @canme 分类名	* @parentid 分类所属id	* */	void addCategory(@Param("cname") String cname, @Param("parentid") Integer parentid);	/*	* 通过分类名获取指定数据	* @canme 分类名	* */	Category getCnameCategory(@Param("cname") String cname);	/*	* 查询所有记录数量	* */	Integer categoryCount();	/*	* 获取所有数据	* */	List<Category> getAllCategory();	/*	* 获取所有数据并按照parentid进行排序	* */	List<Category> getAllCategoryOrderByParentid();	/*	* 根据id获取当前数据	* */	Category getCategory(Integer cid);	/*	* 根据parentid获取数据	* */	List<Category> getParentCategory(Integer parentid);	/*	* 更新数据	* */	void updateCategory(@Param("parentid") Integer parentid, @Param("cname") String cname, @Param("cid") Integer cid);	/*	* 删除数据	* */	void deleteCategory(Integer cid);}