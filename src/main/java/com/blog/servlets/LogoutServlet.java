package com.blog.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.entities.Message;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
HttpSession s=request.getSession();
		
		//removing the session so that we logout
		s.removeAttribute("currentUser");
		
		Message m=new Message("Logout successfully", "success", "alert-success");
		//setting the message to the session
		s.setAttribute("msg", m);
		response.sendRedirect("login_page.jsp");
	
	}
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		HttpSession s=request.getSession();
//		
//		//removing the session so that we logout
//		s.removeAttribute("currentUser");
//		
//		Message m=new Message("Logout successfully", "success", "alert-success");
//		//setting the message to the session
//		s.setAttribute("msg", m);
//		response.sendRedirect("login_page.jsp");
//	}

}
