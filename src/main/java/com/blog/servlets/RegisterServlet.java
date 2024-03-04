package com.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.dao.UserDao;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
//MultipartConfig means servlet requests form type of mime data
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//		doGet(request, response);
		PrintWriter out =response.getWriter();
		
		String check=request.getParameter("check");
		
//		out.println(check);
		
		if(check==null)
		{
			out.println("please check terms and conditions");
		}
		else {
			//fetch out the rest data
			
			String name=request.getParameter("user_name");
			String email=request.getParameter("user_email");
			String password=request.getParameter("user_password");
			String gender=request.getParameter("gender");
			String about=request.getParameter("about");
			// create user object and set the data to that object
			
			User user=new User(name, email, password, gender, about);
//			create a User daoUser object
			UserDao dao=new UserDao(ConnectionProvider.getConnection());
			if(dao.saveUser(user))
			{
//				save
				out.println("done");
			}
			else {
				out.println("error");
			}
		}
	}

}
