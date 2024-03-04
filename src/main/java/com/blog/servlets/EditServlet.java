package com.blog.servlets;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.blog.dao.UserDao;
import com.blog.entities.Message;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import com.blog.helper.Helper;
@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		
		String userEmail=request.getParameter("user_email");
		String userName=request.getParameter("user_name");
		String userPass=request.getParameter("user_password");
		String userAbout=request.getParameter("user_about");
		
		
		//upload file
		
		Part part=request.getPart("image");
		
		String imageName=part.getSubmittedFileName();
		
		//get the user from session
		HttpSession s=request.getSession();
		// this user attribute has the old values so we need to update these with new values
		User user=(User) s.getAttribute("currentUser");
		user.setEmail(userEmail);
		user.setName(userName);
		user.setPassword(userPass);
		user.setAbout(userAbout);
		
//		we will need old image to delete it
		String oldFile=user.getProfile();
		
		user.setProfile(imageName);
		
		// now we have to save these new details in the database too
		// for that we can send this user object to Userdao
		
		//update database
		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		
		boolean ans=userDao.updateUser(user);
		
		String upload_dir="C:\\Users\\HP\\eclipse-workspace\\Blog\\src\\main\\webapp\\profile_pic";
		
		if(ans)
		{
			
			//get the path of the image
			String path=upload_dir+File.separator+user.getProfile();
			String oldPath=upload_dir+File.separator+oldFile;
			
//			if old file is deleted
			
			if(!oldFile.equals("default.png"))
			{
				Helper.deleteFile(oldPath);
			}
				if(Helper.saveFile(part.getInputStream(), path))
				{
					out.println("profile updated...");
	 				Message msg=new Message("Profile details updated", "success", "alert alert-success");
					s.setAttribute("msg", msg);
				}
				else {
					Message msg=new Message("something went wrong, can't update profile", "error", "alert-danger");
					s.setAttribute("msg", msg);
				}
//			}
		}
		else {
			out.println("not updated");
			Message msg=new Message("something went wrong, can't update profile", "error", "alert-danger");
			s.setAttribute("msg", msg);
		}
	
		//redirect to profile page
		response.sendRedirect("profile.jsp");
	}
}
