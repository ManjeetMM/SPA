
var sampleApp = angular.module('helloApp', [Todo,]);
//Define Routing for the application
sampleApp.config(['$routeProvider','$locationProvider',function($routeProvider,$locationProvider) {
      $routeProvider.
          when('/Update', {
              templateUrl: 'jsp/Update.jsp',
              controller: 'cont'
          }).
          when('/Todo', {
              templateUrl: 'jsp/Todo.jsp',
              controller: 'cont'
          }).
          otherwise({
              redirectTo: '/'
          });
      $locationProvider.html5Mode(true);
}]);
sampleApp.controller('cont',function($scope){
	
});
