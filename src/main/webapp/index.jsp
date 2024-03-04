<%@page import="com.blog.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.sql.*" %>


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


	<%@ include file="normal_navbar.jsp" %>
	

	<div class="container-fluid p-0 m-0 banner-background">
		<div class="jumbotron primary-background text-white">
			<div class="container p-5"> 
				<h3 class="display-4">Welcome to our Blog</h3>
				<p>Programming refers to a technological process for telling a computer which tasks to perform in order to solve problems. You can think of programming as a collaboration between humans and computers, in which humans create instructions for a computer to follow (code) in a language computers can understand.
				</p>
				<button class="btn btn-outline-light"><span class="fa fa-external-link"></span>  Start Now! it's free</button>
				<a href="login_page.jsp" class="btn btn-outline-light"><span class="fa fa-user-circle"></span>  Login</a>
				</div>
		</div>
	</div>
	
	<div class="container p-3">
		<div class="row">
		
			<div class="col-md-4">
				<div class="card">
  					<div class="card-body">
    					<h5 class="card-title">Java Programming</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white">Read more</a>
  					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="card">
  					<div class="card-body">
    					<h5 class="card-title">Python Programming</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white">Read more</a>
  					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="card">
  					<div class="card-body">
    					<h5 class="card-title">Java Programming</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white">Read more</a>
  					</div>
				</div>
			</div>
		</div>
		<div class="row">
		
			<div class="col-md-4">
				<div class="card">
  					<div class="card-body">
    					<h5 class="card-title">Java Programming</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white">Read more</a>
  					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="card">
  					<div class="card-body">
    					<h5 class="card-title">Python Programming</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white">Read more</a>
  					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="card">
  					<div class="card-body">
    					<h5 class="card-title">Java Programming</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white">Read more</a>
  					</div>
				</div>
			</div>
		</div>
	</div>
		
		
	<script src="js/myjs.js" type="text/javascript"></script>
	
	<script
  src="https://code.jquery.com/jquery-3.7.0.min.js"
  integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
  crossorigin="anonymous"></script>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

</body>
</html>