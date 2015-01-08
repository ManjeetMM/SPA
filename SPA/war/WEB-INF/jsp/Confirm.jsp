<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<title>Insert title here</title>
</head>
<body style="background-color:#d1ffff" onload="">
<%-- <%=session.getAttribute("password") %> --%>

<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
<center>
<h1 style="font-family:Arial;background-color:#19D175" >Please enter password</h1><hr/>
<form    id='confirm'  action="<%= blobstoreService.createUploadUrl("/uploadimg") %>" method="post" enctype="multipart/form-data" >
<table>
<tr> <td colspan="2"> Enter Your Password </td> <td colspan="2"> <input type="password" name="password" id="password"></td><td> <span  style="color:red" id='p'></span></td></tr>
<tr><td></td><td><input type="file" name="myFile" id='fname'></td><td> <span style="color:red" id="im"></span> <td></tr>
<tr> <td colspan="2"></td> <td colspan="2"> <input type="submit" value="submit" id="submit"> </td> </tr>

</table>
</form>


<!-- ===================================script for password Validation  ================================= -->
<script type="text/javascript">
$(document).ready(function(){
  $("#confirm").submit(function(event){
        
        var password=document.getElementById('password').value;
        var filename=document.getElementById('fname').value;
        console.log(filename);
        if(filename==null || filename==="")
        	{
        	console.log("Optional");
        	}
        var pattern=new RegExp("\w*(JPG|PNG|GIF)$","i");
        if(!(filename==null) && !(filename===""))
        	//console.log("Not Empty or null");
        {
        	console.log("Empty or null");
             if(!file(filename))
        	{
        	  document.getElementById('im').innerHTML="Image File Only";
        	  event.preventDefault();
        	} 
          }
        if(!Password(password))
			{
				//alert('please enter password');
				console.log("Please Enter password")
				document.getElementById('p').innerHTML="Enter your Password";
				event.preventDefault();
			 return ;	
			}
        
        
        function Password(pswd)
	    {
	    	 if(pswd===null || pswd === "" || pswd.length < 6 || pswdValidate(pswd))
	    		 {
	 
	    		 //console.log("in correct password")
	    		 document.getElementById('p').innerHTML="In correct Password";
	    		  return false;
	    		 }
	    	 return true;
	    }
	    
	    
	    
	    function pswdValidate(pswd)
	    {
	    	var r1= new RegExp("[a-z]|[A-Z]","g");
	    	var r2= new RegExp("[@ |!|#|%|^|*|&|(|)|-|_|+|=|/|}|{|,|.|;|: ]","g");  //#$%^&*()_+!?.,-=}{
	    	var r3= new RegExp("[0-9]","g");
	    	
	    		if((pswd.match(r1)&& pswd.match(r3)) && !(pswd.match(r2)))
	    		{
	    		        
	    		         return false;
	    			   
	    		}
	    	return true;
	    	
	    }
	    	
	    	   function file(filename)
	    	 {
	    		 if(filename.match(pattern))
	    			 {
	    			 return true;
	    			 }
	    		 else return false;
	    	 } 
        
    
  });
});

</script>


  <%

response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String email=session.getAttribute("email").toString();
if(session.getAttribute("password").equals("Temp"))
{
	//response.sendRedirect("http://sixthapplication.appspot.com/verified?userid="+email);
}
else
{
	response.sendRedirect("http://angularproject.appspot.com/jsp/Logedin.jsp");
}
    

%>   





</center>
</body>
</html>