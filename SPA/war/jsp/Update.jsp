<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobKey,com.google.appengine.api.images.ImagesService,com.google.appengine.api.images.ImagesServiceFactory" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<!-- <script href="/css/bootstrap.css" rel="stylesheet" ></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">-->
<title>Update Profile</title>
</head>
<body style="background-color:#D1FFFF"><center>
<!-- <h1 style="font-family:Arial;background-color:#19D175">Update Profile</h1>  <hr/>-->


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

<div align="right">
<table>
<%-- <tr><td id="imgd"><img alt="" src="<%=imageUrl %>"></td><tr> --%>  <!-- 18/10/2014 -->
<%-- <tr><th align="center" id="nmd"><%=session.getAttribute("name") %></th></tr> --%>  <!-- 18/10/2014 -->
</table>
</div>

  <form id="update"  enctype="multipart/form-data" >  <!-- onsubmit="return validate();" -->
  <table border="0.2" >    <!-- style="background-color:#47A347" -->
  <tr><td colspan="2" style="font-weight:bold; color:blue">New Name :</td> <td> <input type="text" name="newName" id="newName" placeholder="Enter Name"> </td><td><span id='n1' style="color:red"> </span></td></tr>
  <tr><td colspan="2" style="font-weight:bold; color:blue">Change Password :</td> <td> <input type="password" name="newPassword" id="newPassword" placeholder="Enter Password"> </td><td> <span id='p1' style="color:red"></span></td></tr>
  <tr><td></td><td><input type="file" name="myFile" id='fname'></td><td> <span id="imu" style="color:red"></span> </td></tr>
  <tr><td colspan="2"></td> <th style="background-color:red;" > <input type="submit" value="Update" id="update"> </th></tr>
  </table>
  
  </form>
</center>

<script type="text/javascript">


 
  
  $(document).ready(function(){
	  
	      $('input[type=file]').on('change', function(event){
		    file = event.target.files[0];
		    
		    console.log(file);
		   });
	      //****************************************//
	     
	      //***************************************//
	      
	  $('#update').submit(function(event){
		  
		  var name=document.getElementById('newName').value;
		  console.log(name);
		  var password=document.getElementById('newPassword').value;
		  var filename=document.getElementById('fname').value;
		  console.log(filename);
		  var pattern=new RegExp("\w*(JPG|PNG|GIF)","i");
		  var x={name:name,password:password};
		  console.log("============Data================");
		  console.log(x);
		  console.log("============*Data*================");
		  console.log("File is ther or not"+file);
		  
		  
		  
		  //============================================//
		  
		  if(!filen(filename))
        	{
        	  //document.getElementByID('im').innerHTML="Image file only";
        	  console.log("Here file checking");
        	  document.getElementById('imu').innerHTML="Image File Only";
        	  event.preventDefault();
        	}
		  //============================================//
		  if(!Name(name))
		  {
		   //alert("please enter your name");
		   event.preventDefault();
		   console.log("Please your name");
		   document.getElementById('n1').innerHTML="Enetr your Name";
		   return ;
		  }	
		  
		  
		  if(!Password(password))
			{
				//alert('please enter password');
				console.log("Please Enter password")
				event.preventDefault();
				document.getElementById('p1').innerHTML="Enter Your Password";
			 return ;	
			}
		  //============================================  //
		  
		  if(file!=null)  
		  var formData=new FormData(); //(this)
		  
		   //==========//for(var i = 0; i < file.length; i++) formData.append('myFile'+i, file[i]);//+i
		   
			formData.append('myFile',file);
		    formData.append('name',"Manjeet");
		   //formData.append("name",name); 
		   /*formData.append("password",password);
		   formData.append("email","manjeet.murari@a-cti.com");
		   formData.append("gender","Male"); */
		   console.log(formData);
		 
		   
		   //"/getbloburl"
		    $.ajax({
			  url			:"<%=blobstoreService.createUploadUrl("/updatingimg") %>",
			  type			:'POST',
			  data			: formData,
			  mimeType      :"multipart/form-data",
			  contentType   : false,
			  cache         : false,
			  processData   : false,
			  success		: function(data)
			   {
				  console.log(data);
				  var msg=JSON.parse(data);//here we change the JSON object to 
				  console.log(msg.success);
				  if(data)
					  {
					    //console.log("url:"+msg); 
					    console.log("image uploaded");
					    //document.getElementById('nmd').innerHTML="Manjeet Kumar Singh";
					    console.log("Now for Name and Password :=>");
					    //=============================================//
					        //var img = document.createElement("IMG");//23/10/2014
					        var img=document.getElementById('imgid');
	                        img.src = msg.success;  
					        /* $('#imgd').html(img); */ //18/10/2014
					        $('#logedinimg').html(img);
					        
					   //============================================// 
					   
					      $.ajax({
					    	  
			                    url 	: '/updatename',
			                    type 	: 'POST',
							    dataType: 'json',
								data	: JSON.stringify(x),
								contentType : 'application/json',
			
		   					      success  : function(data1)
			         			        {   
		   						          if(data1){
		   						        	        console.log("updated name :"+data1.name); 
		   						        	        //document.getElementById('nmd').innerHTML=data1.name;  //18/10/2014
		   						        	        document.getElementById('lnm').innerHTML=data1.name;     //18-10-2014
		   						        	        //=====================================
		   						        	        	//document.getElementById('logedinimg').html(img);
		   						        	            //document.getElementById('nml').innerHTML=data1.name;
		   						        	            
		   								             //=================================
		   						        	        
		   						        	       }
		   						          else console.log("********");
			         			        }
					          }); 
					     
					   //=====================================================//
					  }
				  else
					  console.log("error in uploading");
			   }
			  
		});
		    
		
		  function Name(name)
			{
				if(name=== null|| name ==="" || !isNaN(name))
				{
					return false;
				}
					return true;
			}
		  
		  
		  function Password(pswd)
		    {
		    	 if(pswd===null || pswd === "" || pswd.length < 6 || pswdValidate(pswd))
		    		 {
		    		 //alert("incorrect password");//
		    		 console.log("in correct password");
		    		 document.getElementById('p1').innerHTML="Password Must Be Alpha Numeric and length >= 6";
		    		  return false;
		    		 }
		    	 return true;
		    }
		    
		    
		    
		    function pswdValidate(pswd)
		    {
		    	var r1= new RegExp("[a-z]|[A-Z]","g");
		    	var r2= new RegExp("[@ |!|#|%|^|*|&|(|)|-|_|+|=|/|}|{|,|.|;|: ]","g");  //#$%^&*()_+!?.,-=}{
		    	var r3= new RegExp("[0-9]","g");
		    	//alert(pswd);//
		    	//if((pswd.match(r1) && !(pswd.match(r2))) && pswd.match(r3))
		    		if((pswd.match(r1)&& pswd.match(r3)) && !(pswd.match(r2)))
		    		{
		    		        // alert(" yes in Alpha numeric format");
		    		         return false;
		    			   
		    		}
		    	return true;
		    	
		    }
		    	
		    	
		    function filen(filename)
	    	 {
	    		 if(filename.match(pattern))
	    			 {
	    			 return true;
	    			 }
	    		 else return false;
	    	 }
		  
		//============================================================// 
	
	  });
	      
  });
  
</script>



  <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("email")==null)
      response.sendRedirect("http://angularproject.appspot.com/jsp/Login.jsp"); %> 
</body>
</html>