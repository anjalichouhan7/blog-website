package com.blog.dao;
import java.sql.*;
public class Likedao {
	Connection connection;

	public Likedao(Connection connection) {
		this.connection = connection;
	}
	
	public boolean insertLike(int pid, int uid) {
		
		boolean f=false;
		try {
			String q="insert into liked(pid,uid)values(?,?)";
			PreparedStatement pstmt=this.connection.prepareStatement(q);
			
			//values set
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			
			pstmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}

	public int countLikeOnPost(int pid)
	{
		int count=0;
		String query="select count(*) from liked where pid=?";
		try {
			PreparedStatement pstmt=this.connection.prepareStatement(query);
			pstmt.setInt(1, pid);
			
			ResultSet set=pstmt.executeQuery();
			
			if(set.next())
			{
				count=set.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(count);
		return count;
	}

	public boolean isLikedByUser(int pid, int uid)
	{
		boolean f=false;
		try {
			String query="select * from liked where pid=? and uid=?";
			PreparedStatement pstmt=this.connection.prepareStatement(query);
			
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			
			ResultSet set=pstmt.executeQuery();
			if(set.next())
			{
				f=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteLike(int pid, int uid)
	{
		boolean f=false;
		try {
			String query="delete from liked where pid=?, uid=?";
			PreparedStatement pstmt=this.connection.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			
			pstmt.executeUpdate();
			
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return f;
	}
}
