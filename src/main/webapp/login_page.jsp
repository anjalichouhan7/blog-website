<%@page import="com.blog.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>

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
	
	<!--  --><%@include file="normal_navbar.jsp" %>
	
	<main class="d-flex align-items-center primary-background banner-background" style="height: 100vh; padding-bottom: 50px">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4">
				
					<div class="card">
						<div class="card-header primary-background text-white text-center">
						<span class="fa fa-user-circle fa-3x"></span>
							<h5>Login here</h5>
						</div>
						<!-- to show the error on the login page itself ask the session --> 
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
						
						<div class="card-body">
							<form action="LoginServlet" method="post">
							  <div class="mb-3">
							    <label for="exampleInputEmail1" class="form-label">Email address</label>
							    <input name="email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
							    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
							  </div>
							  
							  <div class="mb-3">
							    <label for="exampleInputPassword1" class="form-label">Password</label>
							    <input name="password" required type="password" class="form-control" id="exampleInputPassword1">
							  </div>
							  
							  <div class="container text-center"><button type="submit" class="btn btn-primary primary-background">Submit</button></div>
							  
							</form>
						</div>
					</div>
				</div> 
			</div>
		</div>
	</main>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<script src="js/myjs.js" type="text/javascript"></script>
	
	<script
  src="https://code.jquery.com/jquery-3.7.0.min.js"
  integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
  crossorigin="anonymous"></script>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>