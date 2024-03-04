
<%@page import="com.blog.dao.Likedao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.blog.dao.UserDao"%>
<%@page import="com.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.entities.Posts"%>
<%
//if session has data then login else null and go to login 
User user=(User)session.getAttribute("currentUser");
if(user==null)
{
	response.sendRedirect("login_page.jsp");
}

%>

<%
	int postId=Integer.parseInt(request.getParameter("post_id"));
	PostDao d=new PostDao(ConnectionProvider.getConnection());
	
	Posts p=d.getPostByPostId(postId);
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= p.getpTitle() %></title>
<!-- css -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="css/mystyle.css" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
	.banner-background{
		clip-path: polygon(0 0, 100% 0, 100% 89%, 64% 100%, 33% 91%, 0 100%);
	}
	.post-title{
		font-weight:100px;
		font-size:30px;
	}
	.post-content{
		font-weight:100px;
		font-size:25px;
	}
	.row-user{
		border : 1px solid #e2e2e2;
		padding-top : 15px;
	}
</style>

<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v18.0" nonce="lEfw63DV"></script>

</head>
<body>

	<!-- navbar starts -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary navbar-dark primary-background" >
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp"> <span class="fa fa-address-book"></span> Blogs</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="profile.jsp">Learn coding</a>
        </li>
       
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Categories
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Programming language</a></li>
            <li><a class="dropdown-item" href="#">Build Project</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Learn Data Structure</a></li>
          </ul>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="#">Contact</a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal">Create Post</a>
        </li>
        
      </ul>
      
      <ul class="navbar-nav me-right mb-2 mb-lg-0">
      	<li class="nav-item">
          <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profile-modal"><span class="fa fa-user"></span> <%=user.getName() %></a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="LogoutServlet"><span class="fa fa-toggle-off"></span> LogOut</a>
        </li>
        
      </ul>
    </div>
  </div>
</nav>

	<!-- navbar ends -->
	
	<!-- main content of the body -->
	
	<div class="container">
		<div class="row my-4">
			<div class="col-md-8 offset-md-2">
				<div class="card">
					<div class="card-header primary-background text-white">
						<h4 class="post-title"><%= p.getpTitle() %></h4>
					</div>
					
					<div class="card-body">
						<img src="blog_pics/<%= p.getpPic() %>" class="card-img-top my-2" alt="pic">
						
						<div class="row my-3 row-user" >
							<div class="col-md-8">
							
								<% UserDao ud=new UserDao(ConnectionProvider.getConnection()); %>
								<p class="post-user-info"><a href="#"><%= ud.getUserByUserId(p.getUserId()).getName() %> </a>has posted</p>
							</div>
							<div class="col-md-4">
								<p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
							</div>
						</div>
						
						<p class="post-content"><%= p.getpContent() %></p>
						
						<br>
						<br>
						
						<div class="post-code">
							<pre><%= p.getpCode() %></pre>
						</div>
					</div>
					<div class="card-footer primary-background">
					
						<%
							Likedao ld=new Likedao(ConnectionProvider.getConnection());
						%>
						<a href="#" onclick="doLike(<%=p.getPid() %>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid()) %></span></a>
						<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span> 20</span></a>
					</div>
					
					<div class="card-footer">
						<div class="fb-comments" data-href="http://localhost:8080/Blog/show_blog_page.jsp?post_id=<%= p.getPid() %>" data-width="" data-numposts="5"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- end of main content -->  
	
	<!-- Profile modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header primary-background text-white">
        <h5 class="modal-title" id="exampleModalLabel">Blogs</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="container text-center">
            <img src="profile_pic/<%= user.getProfile() %>" class="img-fluid" style="border-radius: 50%; max-width:100px" >	
        	<h5 class="modal-title" id="exampleModalLabel"><%= user.getName() %></h5>
        	
        	<!--profile details -->
     		<div id="profile-details">
		     	<table class="table">
				  <tbody>
				  	<tr>
				      <th scope="row">User ID</th>
				      <td><%= user.getId() %></td>
				    </tr>
				    <tr>
				      <th scope="row">Email</th>
				      <td><%= user.getEmail() %></td>
				    </tr>
				    <tr>
				      <th scope="row">Gender</th>
				      <td><%= user.getGender() %></td>
				    </tr>
				    <tr>
				      <th scope="row">Status</th>
				      <td colspan="2"><%= user.getAbout() %></td>
				    </tr>
				    <tr>
				      <th scope="row">Registered on</th>
				      <td colspan="2"><%= user.getDateTime().toGMTString() %></td>
				    </tr>
				  </tbody>
				</table>
     		</div>
        	
        	<!-- profile edit -->
        	<div id="profile-edit" style="display:none">
        		<h3 class="mt-2">Please edit carefully</h3>
        		<!-- multipart define that this form contains image or large data -->
        		<form action="EditServlet" method="post" enctype="multipart/form-data">
        			<table class="table">
        				<tr>
        					<td>ID :</td>
        					<td><%= user.getId() %></td>
        				</tr>
        				<tr>
        					<td>Email :</td>
        					<td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
        				</tr>
        				<tr>
        					<td>Name :</td>
        					<td><input type="text" class="form-control" name="user_name" value="<%= user.getName() %>"></td>
        				</tr>
        				<tr>
        					<td>Password :</td>
        					<td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword() %>"></td>
        				</tr>
        				<tr>
        					<td>About :</td>
        					<td><textarea rows="3" class="form-control" name="user_about"><%= user.getAbout() %>	
        					</textarea></td>
        				</tr>
        				<tr>
        					<td>New profile picture :</td>
        					<td>
        						<input type="file" class="form-control" name="image"> 
        					</td>
        				</tr>
        			</table>
        			
        			<div class="container">
        				<button type="submit" class="btn btn-outline-primary ">Save</button>
        			</div>
        		</form>
        	</div>
        	
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" id="edit-profile-button" class="btn btn-primary primary-background">Edit profile</button>
      </div>
      
    </div>
  </div>
</div>

<!-- Modal end -->

<!-- start of add Post modal -->

<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Provide details for post</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
        <form id="add-post-form" action="AddPostServlet" method="post">
        <!-- categories will come from database -->
        
        <div class="mb-2">
        	<select class="form-control" name="cid">
        	<option selected disabled>---Select Category---</option>
        	<%
        		PostDao postd=new PostDao(ConnectionProvider.getConnection());
        		ArrayList<Category> list=postd.getCategories();
        		for(Category cate:list)
        		{
		        	%>
		        	<option value="<%= cate.getCid() %>"><%= cate.getName() %></option>
		        	<%
        		}
        	%>
        	</select>
        </div>
        
        	<div class="mb-2">
        		<input name="pTitle" type="text" placeholder="Enter post title" class="form-control">
        	</div>
        	
        	<div class="mb-2">
        		<textarea name="pContent" style="height:200px" placeholder="Enter your content" class="form-control"></textarea>
        	</div>
        	
        	<div class="mb-2">
        		<textarea name="pCode" style="height:150px" placeholder="Enter your code(if any)" class="form-control"></textarea>
        	</div>
        	
        	<div class="mb-2">
        		<label>select the picture</label><br>
        		<input type="file" name="pPic">
        	</div>
        	
        	<div class="container text-center">
        		<button type="submit" class="btn btn-outline-primary">Post</button>
        	</div>
        </form>
        
      </div>
     
    </div>
  </div>
</div>

<!-- end of add post modal -->
	<script src="js/myjs.js" type="text/javascript"></script>
	
	<script
  src="https://code.jquery.com/jquery-3.7.0.min.js"
  integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
  crossorigin="anonymous"></script>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	<script>
	
		$(document).ready(function(){
			
			let edit_status=false;
			$('#edit-profile-button').click(function(){
				//alert("button clicked");
				
				if(edit_status==false)
				{
					$("#profile-details").hide();
					
					$("#profile-edit").show();
					edit_status=true;
					//changing the text
					$(this).text("Back")
				}
				else
				{
					$("#profile-details").show();
					
					$("#profile-edit").hide();
					edit_status=false;
					//changing the text
					$(this).text("edit");
				}
			})
		});
		
	</script>
	
	<!-- add post js -->
	
	<script>
		$(document).ready(function(e){
			//
			$("#add-post-form").on("submit",function(event){
				//this code gets called when code is submitted......
				event.preventDefault();
				
				//FormData is an object that can hold the form
				
				console.log("you have clicked on post"); 
				let form=new FormData(this);
				
				//now requesting to server
				$.ajax({
					url: "AddPostServlet",
					type:'POST',
					data: form,
					success : function(data,textStatus,jqXHR){
						//success
						//console.log(data);
						
						Swal.fire({
						  icon: 'success',
						  title: 'Done',
						  text: 'Blog posted successfully!'
						})
					},
					error : function(jqXHR,textStatus,errorThrown){
						//error
						Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'Something went wrong!'
						})
					},
					
					processData:false,
					contentType:false
				})
			})
		});
	</script>
</body>
</html>