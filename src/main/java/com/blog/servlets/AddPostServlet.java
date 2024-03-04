package com.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.blog.dao.PostDao;
import com.blog.entities.Posts;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import com.blog.helper.Helper;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PrintWriter out=response.getWriter();
		
		int cid=Integer.parseInt(request.getParameter("cid"));
		String pTitle=request.getParameter("pTitle");
		String pContent=request.getParameter("pContent");
		String pCode=request.getParameter("pCode");
		
		Part part=request.getPart("pPic");
		
		String upload_dir="C:\\Users\\HP\\eclipse-workspace\\Blog\\src\\main\\webapp\\blog_pics";
		
		//getting current user id
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("currentUser");
		
//		out.println("your post title is"+pTitle);
//		out.println(part.getSubmittedFileName());
		
		//create a post
		Posts p = new Posts(pTitle,pContent,pCode,part.getSubmittedFileName(),null,cid,user.getId());
		
		//save in database by creating object of dao class
		PostDao dao=new PostDao(ConnectionProvider.getConnection());
		if(dao.savePost(p))
		{
			
			String path = upload_dir+File.separator+part.getSubmittedFileName();
			Helper.saveFile(part.getInputStream(), path);
			out.println("done");
			
		}
		else {
			out.println("error");
		}
	}
}
