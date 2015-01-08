<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
    <%@ page import="com.google.appengine.api.blobstore.BlobKey,com.google.appengine.api.images.ImagesService,com.google.appengine.api.images.ImagesServiceFactory,com.google.appengine.api.blobstore.BlobInfoFactory,com.google.appengine.api.blobstore.BlobInfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Images List</title>
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>

</head>
<body style="background-color:#D1FFFF" ng-app="website">
<center>

<table style="background-color:"><tr><td><a href="javascript:image();">First Image</a></td>
<td><a href="javascript:image2();">Second Image </a></td>
<td><a href="javascript:image3();">Third Image</a></td>
<td><a href="javascript:image4();">Fourth Image </a></td>
<td><a href="javascript:image5();">Fith Image</a></td>
</tr></table>
<div id="image" align="center" ></div>
<!-- <div id="imgesid"><img id="image" height="100" width="100"></div> -->

<!-- <div align="justify"><a href="javascript:image();">First Image</a></div>
<div align="justify"><a href="javascript:image2();">Second Image </a></div>
<div align="justify"><a href="javascript:image3();">Third Image</a></div>
<div align="justify"><a href="javascript:image4();">Fourth Image </a></div>
<div align="justify"><a href="javascript:image5();">Fith Image</a></div> -->



</center>


<script>
  function image() {
	 var img = document.createElement("IMG");
	 //var img=document.getElementById('image');
	 img.src = "/images/img1.gif";
	 $('#image').html(img);
	 //$('#imagesid').html(img);
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
	$('#image').html(img);
}

</script>
</body>
</html>