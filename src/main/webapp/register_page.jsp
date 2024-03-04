<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration page</title>

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

	<%@include file="normal_navbar.jsp" %>
	
	<main class="primary-background banner-background p-5" style="height: 100vh">
	<div class="container">
		<div class="col-md-6 offset-md-3">
			<div class="card">
				<div class="card-header primary-background text-white text-center ">
					<span class="fa fa-user-plus fa-3x"></span>
					<h5>Register Here</h5>
				</div>
				<div class="card-body">
					<form action="RegisterServlet" method="POST" id="reg-form">
					  <div class="mb-3">
					    <label for="exampleInputEmail1" class="form-label">Email address</label>
					    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
					    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
					  </div> 
					  
					  <div class="mb-3">
					    <label for="user_name" class="form-label">User Name</label>
					    <input name="user_name" type="text" class="form-control" id="user_name" placeholder="Enter name">
					  </div>
					  
					  <div class="mb-3">
					    <label for="exampleInputPassword1" class="form-label">Password</label>
					    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1">
					  </div>
					  
					  <div class="mb-3">
					    <label for="gender" class="form-label">Select Gender</label>
					    <br>
					    <input type="radio" name="gender" id="gender" value="male">Male
					    <input type="radio" name="gender" id="gender" value="female">Female
					  </div>
					  
					  <div class="mb-3">
					    <textarea name="about" class="form-control" rows="5" placeholder="enter something about yourself"></textarea>
					  </div>
					   
					  <div class="mb-3 form-check">
					    <input name=check type="checkbox" class="form-check-input" id="exampleCheck1">
					    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions</label>
					  </div>
					  
					  <div class="container text-center" id="loader" style="display:none;">
					  	<span class="fa fa-refresh fa-spin fa-3x"></span>
					  	<h4>Please wait</h4>
					  </div>
					  
					  <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	</main>
	


	<!-- javascript -->
	
	
	
	<script src="js/myjs.js" type="text/javascript"></script>
	
	<!-- sweetalert js -->
	   <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	
	<script
  src="https://code.jquery.com/jquery-3.7.0.min.js"
  integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
  crossorigin="anonymous"></script>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
	

	<script>
		$(document).ready(function(){
			console.log("loaded.....");
			
			$('#reg-form').on('submit',function(event){
				event.preventDefault();
				
				
				
				
				//fetch the data of entire form in form object
				let form=new FormData(this);
				
				//before sending the data to servlet
				
				$('#submit-btn').hide();
				$('#loader').show();
				
				//send this data to register servlet
				
				$.ajax({
					url :"RegisterServlet",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR){
						//console.log(data);
						
						$('#submit-btn').show();
						$('#loader').hide();
						
						//swal("successfully submitted");
						if(data.trim()==="done"){
							swal("registered successfully, we are redirecting you to login Page")
							.then((value) => {
							  window.location="login_page.jsp"
							});
						}
						else{
							swal(data);
						}
					},
					error : function(jqXHR, textStatus, errorThrown){
						
						 //console.log(jqXHR);
						$('#submit-btn').show();
						$('#loader').hide();
						
						swal("Something went wrong, Please try again");
					},
					
					// what we want to process 
					processData: false,
					contentType: false
				});
			});
		});
	</script>
</body>
</html>