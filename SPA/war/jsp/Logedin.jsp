<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
    <%@ page import="com.google.appengine.api.blobstore.BlobKey,com.google.appengine.api.images.ImagesService,com.google.appengine.api.images.ImagesServiceFactory,com.google.appengine.api.blobstore.BlobInfoFactory,com.google.appengine.api.blobstore.BlobInfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="website">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
<meta http-equiv="pragma" content="no-cache" />
<title>Home Page</title>
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>

<!-- ===================================================== -->
<!-- <script	src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.18/angular.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.18/angular-route.js"></script> -->

<script src="http://code.angularjs.org/angular-1.0.0rc6.min.js"></script>
<script src="/js/website.js"></script>

  <!--  <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  </head> -->

<!-- ===================================================== -->
</head>
<body style="background-color:#D1FFFF" ng-controller="MainCtrl" >


<center>
<!-- <div ng-view></div> --> 

<h1 style="font-family:Arial;background-color:#19D175">  Home Page </h1><hr/>

	<% if(session.getAttribute("name")==null || session.getAttribute("name").equals(""))
		{ 
			response.sendRedirect("http://angularproject.appspot.com/jsp/Login.jsp"); 
		} 
	%>

<!-- ========Getting The Image -->
<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>

 <%
String imageUrl;
if( !session.getAttribute("Image").toString().equals("nothing"))
{
BlobKey bk=(BlobKey)session.getAttribute("Image");
System.out.print(bk);
ImagesService imagesService = ImagesServiceFactory.getImagesService();
 imageUrl = imagesService.getServingUrl(bk);
}
else { imageUrl="/images/img5.png"; }
%>

<!-- ========================= -->
<div align="right"  style="position: absolute; top: 80px; right: 30px; width: 240px;">
<table>
<tr><td id="logedinimg"><img alt="" src="<%=imageUrl %>" height="120" width="230" id="imgid"></td><tr>
<tr><th align="center" id="lnm"><%=session.getAttribute("name") %></th></tr>
<tr><th align="center" style="color:blue"><em></em><%=session.getAttribute("email") %></th></tr>
</table>
</div>
<table>
<div ng-view></div> 
</table>
<!-- <script type="text/javascript">
	function l_Click()
	{
		window.location.assign("http://localhost:8888/jsp/Logout.jsp");
	};
</script> -->

<script>
  function image() {
	 var img = document.createElement("IMG");
	 img.src = "/images/img1.gif";
	 $('#image').html(img);
 }

 function image2() {
	var img = document.createElement("IMG");
	img.src = "/images/img2.png";
	$('#image').html(img);
 }

 function image3() {
	var img = document.createElement("IMG");
	img.src = "/images/img3.gif";
	$('#image').html(img);
}
function image4() {
	var img = document.createElement("IMG");
	img.src = "/images/img4.jpg";
	$('#image').html(img);
}
function image5() {
	var img = document.createElement("IMG");
	img.src = "/images/img5.png";
	//document.getElementByID('image').addChild(img);
	$('#image').html(img);
}

</script>
</head>


<!-- <div id="image" align="right"></div>
<div align="left"><a href="javascript:image();">First Image</a></div>
<div align="left"><a href="javascript:image2();">Second Image </a></div>
<div align="left"><a href="javascript:image3();">Third Image</a></div>
<div align="left"><a href="javascript:image4();">Fourth Image </a></div>
<div align="left"><a href="javascript:image5();">Fith Image</a></div>           24/10/2014-->

</center>
<center>
<br/><br/>
<div  style="position: absolute; bottom: 25px; left:580px; width: 240px;">
<form  id="fm">
<input type="submit" value="LOGOUT" id="submit">
</form>
<br/>
<a ng-click="setRoute('Update')"><button>Update</button></a>
<a ng-click="setRoute('Todo')"><button>Todo</button> </a> 
<a ng-click="setRoute('Images')"><button>Images</button></a>
<!-- <a ng-click="setRoute('Images')"><button>Images</button></a> -->
</div>

<!-- <div ng-view></div>                                  21/10/2014  -->
 <!-- <table border="1" >
  <tr><th colspan="2"> <u>Task </u></th><th><u> Status </u></th></tr>
  <tr ng-repeat="todo in all"> <td colspan="2"> {{todo.task}} </td><td> {{todo.status}} </td></tr>
  </table> -->
</center>



<script type="text/javascript">
//=============================== 21/10/2014==========================//



  $(document).ready(function()
 {
	  //=================================================//========================Starts=== 21/10/2014==========================//
	  $.ajax({
		     url:'/getData',
		     type:'GET',
		     success:function(data)
		     {
		    	 if(data)
		    		 {
		    		 console.log("getting data here in loged in page: ");
		    		  console.log(data);
		    		 }
		    	 
		     }
		  
	        });
	  //=====================================================//=======================End Here ======== 21/10/2014==========================//
	  
	$('#fm').submit(function(event){
	
		event.preventDefault();
		//var x = {email:email,password:password};
		$.ajax(
				{
				url  :'/logout',
				type :'POST',
				//dataType: 'json',
				//data :JSON.stringify(x),
				//contentType : 'application/json',	
				data :'',
				success :function(data)
				{
					if(data.logout==="logout")
						{
						  document.location.assign("http://angularproject.appspot.com/jsp/Login.jsp");
						}
				}
				
				});
	});
   });
</script>

<% 

  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("name")==null)
      response.sendRedirect("http://angularproject.appspot.com/jsp/Login.jsp");

  %>
<!-- <script type="text/javascript">
//define angular module for my app
var sampleApp = angular.module('LinApp', []);
//Define Routing for the application
sampleApp.config(['$routeProvider','$locationProvider',function($routeProvider,$locationProvider) {
      $routeProvider.
          when('/Update', {
              templateUrl: 'views/Update.jsp',
              controller: 'cont'
          }).
          when('/Todo', {
              templateUrl: 'views/Todo.jsp',
              controller: 'cont'
          }).
          otherwise({
              redirectTo: '/'
          });
      $locationProvider.html5Mode(true);
}]);
sampleApp.controller('cont',function($scope){
	
});
</script> -->


</body>
</html>