<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
    <%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
    <%@ page import="com.google.appengine.api.blobstore.BlobKey,com.google.appengine.api.images.ImagesService,com.google.appengine.api.images.ImagesServiceFactory,com.google.appengine.api.blobstore.BlobInfoFactory,com.google.appengine.api.blobstore.BlobInfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> <!-- PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="/jsLib/jquery-1.11.1.min.js"></script>
<!-- <script type="text/javascript" src="/js/angular.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"> -->

<title>Todo Page</title>
</head>
<body  ng-app="website" style="background-color:#D1FFFF">  <!-- ng-app="To" -->
<center>
<!-- <h1 style="font-family:Arial;background-color:#19D175"  >Add Your Task</h1><hr/> -->

<% if(session.getAttribute("name")==null || session.getAttribute("name").equals(""))
		{ 
			response.sendRedirect("http://angularproject.appspot.com/jsp/Login.jsp"); 
		} 
	%>


<form ng-submit="submit()" ng-controller="SecondCtrl">
<div id="sbm" align="left"  style="position: absolute; top: 80px; left: 40px; width: 700px;">
  <table>
            <tr>
            <td>Type of work</td> <td><input type="text" ng-model="text" name="text"  placeholder="Enter Your Task"  /><td>
            <td><input type="date" id="datepick" name="date" ng-model="date"></td>
            <td><input type="time" name="usr_time" value="19:47:AM/PM" ng-model="time"></td>
            <td><input type="submit" id="submit" value="Add Task"/></td>
           </tr>
 </table>
 <b>Pending Task</b>
  <table >
                     <tr><th colspan="2"></th><th colspan="2"> <u>Task </u></th><!-- <th><u> Status </u></th> --><th><u>Expected Date</u></th><th><u>Time</u></th></tr>
                     <tr ng-repeat="todo in all" ><td colspan="2" id={{todo.task}} ng-click="click($event)" value={{todo.date}}><input type="checkbox" name="Change" value={{todo.task}}></td>
                     <!-- contenteditable='true' --><td colspan="2"   id={{todo.date}}  onclick="changeTask(event)"> <label id={{todo.date}}  contenteditable='true'>{{todo.task}}</label> </td>
                               <!-- <td> {{todo.status}} </td> -->
                               <td>{{todo.date}}</td>
                               <td>{{todo.time}}</td>
                               
                               
                    </tr>
                    
                    <!-- <input type="button" id={{todo.task}} value="Edit" onclick="changeTask(event)"/> -->
  </table>
  
  </div>
  <div  align="right"  style="position: absolute; top: 101px; right: 350px; width: 340px;">
  <b>Completed Task&nbsp;&nbsp;</b>
  <table >
  				<tr><th colspan="2"> <u>Task </u></th><!-- <th><u> Status </u></th> --><th><u>Completed On</u></th><th><u>Time</u></th></tr>
  				<tr ng-repeat="complete in completed" id={{complete.task}}> 
  					<td colspan="2"> {{complete.task}} </td>
  					<!-- <td> {{complete.status}} </td> -->
  					<td>{{complete.date}}</td>
  					<td>{{complete.time}}</td>
  				</tr>
  </table>
  </div>
  
  </form>
  
 
  <div  id="f1"></div>
  
  <script type="text/javascript">
  
    function SecondCtrl($scope,$http)
    {
      
	  var x='';
		  $scope.all=[];//=======Array which holds JSON Object for all Task 
		  
		  //========================27/10/2014===============================//
		    $scope.completed=[]; 
		  
		    $http.get('/getCompleted').success(function(data)
		  		  {
		  			console.log(data);
		  			var key =Object.keys(data);
		  			console.log(key);
		  			//$scope.all=[data];
		  			//$scope.all.push({"task":data.name,"status":data.status});//****
		  			for(var i=0;i<key.length;i++)
		  				{
		  				console.log("fetching Date when to do is loding"+data[i].date);
		  				console.log("fetching Date "+data[i].date);
		  				console.log("fetching Time from Data Base for completed one"+data[i].time);
		  				$scope.completed.push({"task":data[i].name,"status":data[i].status,"date":data[i].date,"time":data[i].time});
		  				}
		  		  }
		  		  ); 
		  
		  
		  //================================================================//
		  //========================================================================//
		  $http.get('/getData').success(function(data)
		  {
			console.log(data);
			var key =Object.keys(data);
			console.log(key);
			//$scope.all=[data];
			//$scope.all.push({"task":data.name,"status":data.status});//****
			for(var i=0;i<key.length;i++)
				{
				$scope.all.push({"task":data[i].name,"status":data[i].status,"date":data[i].date,"time":data[i].time});
				}
		  }
		  ); 
		  //=======================================================================//
	  $scope.submit=function()
	  {
	   var ctDate= new Date();
		if($scope.date==null && $scope.time==null) 
			{
			var tempDate=""+ctDate.getFullYear()+"-"+(ctDate.getMonth()+1)+"-"+ctDate.getDate();
			//$scope.date=""+ctDate.getFullYear()+"-"+(ctDate.getMonth()+1)+"-"+ctDate.getDate();
			console.log("Current Date is "+tempDate);
			var tempTime=""+ctDate.getHours()+":"+ctDate.getMinutes();
			console.log("current Time is"+tempTime);
			//$scope.date=tempDate;
			//$scope.time=tempTime;
			$scope.date="mm/dd/yyyy";
			$scope.time="--:-- --";
			}
		else if($scope.date==null)
			{
			$scope.date="mm/dd/yyyy";
			}
		else if($scope.time==null)
			{
			$scope.time="--:-- --";
			}
		  if($scope.text && $scope.date && $scope.time)
			  {
			    console.log("Your Date is :"+$scope.date);
			    console.log("============29/10/2014===============");
			    console.log("Your time is :"+$scope.time);
			    console.log("===========================");
			    x={name:$scope.text,status:"pending",date:$scope.date,time:$scope.time};//this.text  $scope.time 29/10/2014
			    
			    
			    angular.copy($scope.text,"");
			    /* $scope.text=null;
			    $scope.date=null;
			    $scope.time=null; */
			   
			    
			  }
			  
		      var resp=$http.post("/something",x);
		      resp.success(function(data, status, headers, config){
			  console.log("Submited");
			  console.log(data);
			  console.log(data.name);
			  console.log(data.date);//
			  //Here i am getting ata back and appending to the all
			  console.log("Getting time from database after adding");
			  console.log(data.time);
			  //==================================================//
			  $scope.all.push({"task":data.name,"status":data.status,"date":data.date,"time":data.time});//here making JSON object when server returns somethig
			  console.log("checking what is the valu of the field");
			  console.log("Value of the text field is :"+$scope.text);
			  
			  //document.location.assign("http://angularproject.appspot.com/jsp/Todo.jsp");//Logedin.jsp
			  
		  });
		  resp.error(function(data, status, headers, config){
			 
			  console.log("Getting error while submiting /something");
		  });
		  
	  };
	  //Here I am geeting the id of the row whose status is going to be change 
	  $scope.click=function($event)
	  {
		  var dt='';
		  var tm='';
		  //=========================29/10/2014=============//
		  var ctDate= new Date();
		//==================================================//
		 console.log(event.currentTarget);
		 var v=event.currentTarget.id;
		
		 console.log("Your id is:"+v);
		
		 var y={name:v};
		 var resp1=$http.post("/Datadate",y);
		 resp1.success(function(data, status, headers, config){
			 console.log("Getting Date from DataBase ");
			 console.log("Data Is :"+data.date);
			 //dt=data.date;
			 //==================================29/10/2014===========================//
			 dt=""+ctDate.getFullYear()+"-"+(ctDate.getMonth()+1)+"-"+ctDate.getDate();
			 //======================================
			 console.log("Time is:"+data.time);
			 //tm=data.time;
			 //==================================29/10/2014===========================//
			 tm=""+ctDate.getHours()+":"+ctDate.getMinutes();
		     //========================================== 
			 console.log("===================================");
			 console.log("Dt value is "+dt);
			 console.log("Tm value is"+tm)
			 
		 
		 
		 console.log("Outside I am printing the value of dt :"+dt+"Time is "+tm);
		
		 console.log($scope.all);
		 console.log($scope.all[0]);
		 var index=-1;
		 for(var i=0; i<$scope.all.length; i++)
			 {
			   //console.log($scope.all[i].task);
			   if($scope.all[i].task===v)
				   {
				    index=i;
				   }
			   
			 } 
		 console.log("your index no is:"+index);
		 
		 if(index >-1)
			 {
			  $scope.all.splice(index ,1);
			  //$scope.all.push({"task":v,"status":"completed"}); //27/10/2014
			  
			  $scope.completed.push({"task":v,"status":"completed","date":dt,"time":tm});
			  
			
			  		  
			  		  x={name:v,status:"completed",date:dt,time:tm};
			  		  var re=$http.post("/something",x);
			  		  re.success(function(data,status,headers,config)
			  				  {
			  			      	
			  			  		console.log("going to change");
			  			       
			  			  
			  		          });
			  		  
			  
			  
			  
			 }
		 });//here i am putting
	  };
    }
    
    
    function changeTask(event)
    {
    	var idt=event.currentTarget.id;
    	console.log(event.currentTarget.id);
    	//var c=document.getElementById(''+idt).value;
    	//console.log("Your new Value is "+c);
    	var vl=document.getElementById(''+idt).innerText;
    	console.log("getting value using jquery is:"+vl);
    	console.log("Responding on click event");
    	
    }
  /* }); */
  </script>
 
  
 <!-- <script type="text/javascript">
 var myFn=function(e)
 {
	 $(e.currentTarget);
	 
 };
 </script> -->
</center>
</body>
</html>