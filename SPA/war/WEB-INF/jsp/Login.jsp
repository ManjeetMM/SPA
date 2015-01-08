<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/angular.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular-route.js"></script>
<title>: Login Page : </title>
</head>
<body style="background-color:#D1FFFF" onload="myFunction()" ng-app="Login">

<center><h1 style="font-family:Arial;background-color:#19D175">: Login Page :</h1> <hr/>
<form   id="login"  ng-submit="submit()" ng-controller="ExampleCtrl">
<table>

<tr><td colspan="2" style="font-weight:bold;">Email:</td><td> <input type="text" name ="email" id="email" onblur="myFu()" onfocus="focusFunction()" ng-model="email"> </td> <td colspan="2"> <span id="eml" style="color:red"></span></td></tr>
<tr><td colspan="2" style="font-weight:bold;">Password:</td><td> <input type="password" name ="password" id="password" onblur="myFu2()"  onfocus="focusFunction2()"ng-model="password"> </td> <td colspan="2"> <span id="psw" style="color:red" ></span> </td> </tr>
<tr><td colspan="2" style="font-weight:bold;"> &nbsp; &nbsp; &nbsp;</td><td> <input type="submit" value="submit" id="submit"> </td></tr>
</table>
<span id="su"></span>

</form>
</center>
<!--========Angular Js===============-->

<script>

angular.module("Login",[]).controller("ExampleCtrl",function($scope,$http){
	var x='';
	$scope.submit=function()
	{
	if($scope.email && $scope.password)
		{
		x={email:this.email,password:this.password};
		}
	
	 var resp=$http.post("/login",x);
	 resp.success(function(data, status, headers, config){
		console.log("Inside login"); 
		console.log(data.sucess);var msg=data.sucess;
		if(msg==="sucess")
			{ document.location.assign("/jsp/Logedin.jsp");   }
		else
			{
			document.getElementById('su').innerHTML="Wroeng ID or Password";
			}
		//document.location.assign("/jsp/Logedin.jsp"); 24/10/2014
	 });
	 resp.error(function(data, status, headers, config){
		 console.log("something went wrong");
	 });
	 
	};
});
</script>




<!--========End of Angular Js========-->

<!-- <script type="text/javascript">


$(document).ready(function(){
	
	$('#login').submit(function(event){
		
		event.preventDefault();
		
		var email=document.getElementById('email').value;
		
		var password=document.getElementById('password').value;
		
		if(!validate(email))
		{
			//alert("Please enter email");
			console.log("Please enter Email");
			document.getElementById('eml').innerHTML="Plz enter Email";
			
			return;
		}
		if(!validate(password))
			{
			 // alert("please enter password" );
			 console.log("Please enter password :");
			 document.getElementById('psw').innerHTML=" Plz Enetr Password";
			 return ;
			}
		
		var x = {email:email,password:password};
		
		$.ajax({
			url 	: '/login',
			type 	: 'POST',
			dataType: 'json',
			data	:  JSON.stringify(x),
		contentType : 'application/json',
			
		   success  : function(data)
			         {
					  console.log(data);
					  var msg=data.sucess;
					  if(msg==="sucess")
						  {
						  document.location.assign("/jsp/Logedin.jsp");
						  }
					  else
						  {
						
					       console.log("Wrong id or Password");
					       document.getElementById('su').innerHTML="Wrong Email Id or Password";
						  }
				
			         }
			
		});
		
		

		function validate(data)
		{
			if(data == null || data == "")
    		{
    			return false;
    		}
			else
			{
				return true;
			}
		}
			
	});
	
});
 -->

    
    
    
    <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if( session.getAttribute("email")!=null)
      response.sendRedirect("http://angularproject.appspot.com/jsp/Logedin.jsp");

  %> 
    
    
   <script type="text/javascript">
   
   function myFunction()
   {
	   var x={name:"manjeet"};
	  $.ajax(
			 
			  {
				  url     		:'/index',
				  type    		:'POST',
				  datType 		:'json',
				  data    		:JSON.stringify(x),
				  contentType	:'application/json',
				  
				  success :  function(data)
				  {
					  var ms=data.success;
					  console.log(ms);
					  if(ms === "success")
						  {
					       document.location.assign("http://angularproject.appspot.com/jsp/Logedin.jsp");
						  }
						  
				  }
			  
			  });
   }
   </script> 
   <script>
   
   function focusFunction() {
	    document.getElementById("email").style.background = "yellow";
	}
   
   function focusFunction2() {
	    document.getElementById("password").style.background = "yellow";
	}
   
   
   function myFu()
   {
	   console.log("inside on blur function")
	  var name=document.getElementById('email').value;
	  
	  if(name == null || name==="")
		  {
		   document.getElementById('eml').innerHTML="plz enetr The Data";
		   document.getElementById('email').style.background="";
		  }
	  else
		  document.getElementById('eml').innerHTML="";
	      document.getElementById('email').style.background="";
	  
   }
   
   function myFu2()
   {
	   console.log("inside on blur function")
	  var password=document.getElementById('password').value;
	  
	  if(password == null || password==="")
		  {
		   document.getElementById('psw').innerHTML="plz enetr The Data";
		   document.getElementById('password').style.background="";
		  }
	  else
		  document.getElementById('psw').innerHTML="";
	  document.getElementById('password').style.background="";
	  
   }
   
   </script>
    
    
</body>
</html>