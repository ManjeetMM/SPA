<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/js/angular.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular-route.js"></script>
    <title>Registration</title>
  </head>

  <body style="background-color:#D1FFFF" ng-app="MyApp"><center>
    <h1 style="font-family:Arial;background-color:#19D175">Registration Form :</h1><hr/>
	
    
    <form   ng-submit="submit()" ng-controller="Registration">  <!--  onsubmit="return validate();"-->
    <table>
      <tr>
        <td colspan="2" style="font-weight:bold;">Name: </td> <td> <input type="text" name="n1" id="name" ng-model="n1"  placeholder="Enter Name"><span id="nm" style="color:red"></span></td>
      </tr>
      <tr>
        <td colspan="2" style="font-weight:bold;">Email: </td> <td> <input type="text" name="em" id="email" ng-model="em" placeholder="Enter email"> <span id="em" style="color:red" ></span> </td>      
      </tr>
      <tr>
        <td colspan="2" style="font-weight:bold;">Gender: </td> <td> <input type="text" name="gn" id="gender" ng-model="gn"  placeholder="Enter Gender"><span id="gn" style="color:red" ></span> </td>      
      </tr>
      <tr>
        <td  colspan="2" style="font-weight:bold;"></td><td><input type="submit" value="submit" id="submit"></td>
      </tr>
    </table>
    </form>
    <span id="sp" style="color:green"></span>
    </center>
 
    <script type="text/javascript">
    angular.module("MyApp",[]).controller("Registration", function($scope, $http){
	  var x='';
	  
	  $scope.submit=function()
	  {
		  if($scope.n1 && $scope.em  && $scope.gn)
			  {
			  x={name:this.n1,email:this.em,gender:this.gn,password:"Temp"};
			  }
		      
		      var resp=$http.post("/reg",x);
		      resp.success(function(data, status, headers, config)
		    {
			  console.log("Submited");
			  document.getElementById('sp').innerHTML="Email Sent for verification";
			  
		  });
		  resp.error(function(data, status, headers, config){
			 
			  console.log("Getting error while submiting");
		  });
		  
	  };
	  
  });
  </script>
  
 
    
    </body>
</html>