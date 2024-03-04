package com.blog.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.blog.entities.Category;
import com.blog.entities.Posts;
public class PostDao {
	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}
	
	
	//function that returns all the categories
	public ArrayList<Category> getCategories(){
		ArrayList<Category> list=new ArrayList<>();
		try {
			String q="select * from categories";
			Statement stmt=this.con.createStatement();
			ResultSet rSet=stmt.executeQuery(q);
			
			while(rSet.next())
			{
				int cid=rSet.getInt("cid");
				String name=rSet.getString("name");
				String desc=rSet.getString("description");
				
				Category category=new Category(cid,name,desc);
				list.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public boolean savePost(Posts pst) {
		boolean flag=false;
		try {
			String queryString="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
			
			PreparedStatement pstmt=con.prepareStatement(queryString);
			pstmt.setString(1, pst.getpTitle());
			pstmt.setString(2, pst.getpContent());
			pstmt.setString(3, pst.getpCode());
			pstmt.setString(4, pst.getpPic());
			pstmt.setInt(5, pst.getCatId());
			pstmt.setInt(6, pst.getUserId());
			
			pstmt.executeUpdate();
			
			flag=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public List<Posts> getAllPost(){
		List<Posts> list=new ArrayList<>();
		//fetch all posts
		
		try {
			PreparedStatement pstmt=con.prepareStatement("select * from posts order by pid desc");
			ResultSet set=pstmt.executeQuery();
			
			while(set.next())
			{
				int pid=set.getInt("pId");
				String pTitle=set.getString("pTitle");
				String pContent=set.getString("pContent");
				String pCode=set.getString("pCode");
				String pPic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int catId=set.getInt("catId");
				int userId=set.getInt("userId");
				
				Posts post=new Posts(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
				
				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Posts> getPostsByCatId(int catId)
	{
		List<Posts> list=new ArrayList<>();
		//fetch all posts by id
		try {
			PreparedStatement pstmt=con.prepareStatement("select * from posts where catId=?");
			pstmt.setInt(1, catId);
			ResultSet set=pstmt.executeQuery();
			
			while(set.next())
			{
				int pid=set.getInt("pId");
				String pTitle=set.getString("pTitle");
				String pContent=set.getString("pContent");
				String pCode=set.getString("pCode");
				String pPic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int userId=set.getInt("userId");
				
				Posts post=new Posts(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
				
				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Posts getPostByPostId(int postId) {
		Posts post=null;
		try {
			String query="select * from posts where pid=?";
			PreparedStatement pstmt=this.con.prepareStatement(query);
			pstmt.setInt(1, postId);
			
			ResultSet set=pstmt.executeQuery();
			
			if(set.next())
			{
				int pid=set.getInt("pId");
				String pTitle=set.getString("pTitle");
				String pContent=set.getString("pContent");
				String pCode=set.getString("pCode");
				String pPic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int cid=set.getInt("catId");
				int userId=set.getInt("userId");
				
				post=new Posts(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	return post;
	}
}
