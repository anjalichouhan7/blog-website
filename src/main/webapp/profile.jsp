
<%@page import="com.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.entities.Message"%>
<%@page import="com.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<!-- fetch user from session but we do not need to use getSession because session is by default -->

<%
//if session has data then login else null and go to login 
User user=(User)session.getAttribute("currentUser");
if(user==null)
{
	response.sendRedirect("login_page.jsp");
}

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<!-- css -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="css/mystyle.css" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
	.banner-background{
		clip-path: polygon(0 0, 100% 0, 100% 89%, 64% 100%, 33% 91%, 0 100%);
	}
</style>

</head>
<body>

	<%-- <%= user.getName() %>
	<br>
	<%= user.getEmail() %>
	<br>
	<%= user.getAbout() %>  --%>
    
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
          <a class="nav-link active" aria-current="page" href="#">Learn coding</a>
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
	<!-- message starts -->
	<% 
	
						Message m=(Message)session.getAttribute("msg"); 
						
						//when we refresh session is null and when we give wrong details it will go to loginServlet and if(usr==null) will get executed and it will create a message and get the session and set the message in the session and then redirect to login page and here we are checking if msg is null or not, if not null then print the msg then remove it so that when we refresh we will not get the msg again 
						if(m!=null)
						{
						%>
						
						<div class="alert <%=m.getCssClass() %>" role="alert">
  <%= m.getContent() %>
</div>

						<% 
						session.removeAttribute("msg");  
						}
						%>
	<!-- message ends -->
	
	<!-- main section of the page starts -->
	<main>
		<div class="container">
		
			<div class="row mt-4">
				<!-- first column -->
				<div class="col-md-4">
					<!-- categories  -->
					<div class="list-group">
					  <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active" aria-current="true">
					    All post
					  </a>
					  <!-- categories from database-->
					  <%
					  	PostDao d=new PostDao(ConnectionProvider.getConnection());
					  	ArrayList<Category> list1=d.getCategories();
					  	
					  	for(Category cc:list1)
					  	{
					  %>
					  		
					  		<a href="#" onclick="getPosts(<%= cc.getCid() %>,this)" class="c-link list-group-item list-group-item-action"><%=cc.getName() %></a>
					  		
					  <%
					  		
					  	}
					  %>
					  
					</div>
				</div>
				
				<!-- second column -->
				<div class="col-md-8">
					<!-- post -->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-2x fa-spin"></i>
						<h3 class="mt-2">Loading....</h3>
					</div>
					
					<div class="container-fluid" id="post-container">
					
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- modal start -->

<!-- Modal start-->
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
	
	<!-- loading post using ajax -->
	
	<script>
	
	//temp will store the active link category 
		function getPosts(catId,temp)
		{
			$("#loader").show();
			$("#post-container").hide();
			
			// remove category active
			$(".c-link").removeClass('active')
			$.ajax({
				url : "load_posts.jsp",
				data : {cid : catId},
				success : function(data,textStatus,jqXHR){
					console.log(data);
					$("#loader").hide();
					$("#post-container").show();
					$('#post-container').html(data);
					
					$(temp).addClass('active')
				}
			})
		}
		
		$(document).ready(function (e){
			
			//by default all categories will be inactive but we want to active all posts by default
			let allPostRef=$('.c-link')[0];
			
			getPosts(0,allPostRef);
		})
	</script>
</body>
</html>