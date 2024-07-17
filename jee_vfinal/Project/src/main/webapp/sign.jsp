<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
  	<title>Sign In</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="/Project/Bocor/Bocor/assets/img/jkl.png" rel="icon">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link href="/Project/login-form-20" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="/Project/login-form-20/css/style.css">

	</head>
	<body class="img js-fullheight" style="background-image: url(/Project/login-form-20/images/klo.jpg);">
	<section class="ftco-section" style="margin-left: 30%;">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Sign up</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<h3 class="mb-4 text-center"></h3>
		      	<form action="authen" class="signin-form">
		      		<div class="form-group">
		      			<input type="text" class="form-control" placeholder="Username" name="nm" required></div>
		      					      		<div class="form-group">
		      			<input type="text" class="form-control" placeholder="phone" name="pn" required></div>
		      		   		      		<div class="form-group">
		      		    <input type="text" class="form-control" placeholder="email" name="ml" required>
		      		</div>
	            <div class="form-group">
	              <input id="password-field" type="password" class="form-control" name="ps" placeholder="Password" required>
	            </div>
	            <div class="form-group">
	            	<button type="submit" class="form-control btn btn-primary submit px-3">Confirm</button>
	            </div>
	           
	          </form>
	        
		      </div>
				</div>
			</div>
		</div>
	</section>

	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>

	</body>
</html>

