package com.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.dao.UserDao;
import com.blog.entities.Message;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out=response.getWriter();
		//fetch the email and password from login page
		String userEmail=request.getParameter("email");
		String userPassword=request.getParameter("password");
		
//		sending the data to userdao to check if the user exists or not
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		User usr=dao.getUserByEmailAndPassword(userEmail, userPassword);
		
		if(usr==null)
		{
			//login error
			
			//out.println("invalid details..., please try again");
			Message msg=new Message("invalid details! Try with another", "error", "alert-danger");
			
			HttpSession session=request.getSession();
			session.setAttribute("msg", msg);
			response.sendRedirect("login_page.jsp");
		}
		else {
//			login success
			
			//create a session so that it will remain till the user logout or close the browser
			HttpSession session=request.getSession();
			session.setAttribute("currentUser",usr);
			//redirect to profile page
			response.sendRedirect("profile.jsp");
		}
	}

}
