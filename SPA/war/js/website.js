
angular.module('website',[]).config(function($routeProvider)
		{
	      $routeProvider.when('/Update',{template:'/jsp/Update.jsp'}).
	                     when('/Images',{template:'/jsp/Images.jsp'}).
	                     when('/Todo',{template:'/jsp/Todo.jsp'});
	                     /*.otherwise({redirectTo:'/',template:'/'});*/
	                     
        });

    function MainCtrl($scope,$location)
     { 
    	$scope.setRoute=function(route)
	    {
	       $location.path(route);
	    }
     }
    