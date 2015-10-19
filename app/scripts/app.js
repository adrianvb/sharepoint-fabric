'use strict';

var app = angular.module('servicesApp', [
  'ExpertsInside.SharePoint.List',
  'ngRoute',
  'angular.filter'
]);

app.factory('Service', function($spList) {
  return $spList('Services');
});

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/services', {
        templateUrl: 'partials/service-list.html',
        controller: 'ServiceListCtrl'
      }).
      when('/services/:id', {
        templateUrl: 'partials/service-detail.html',
        controller: 'ServiceDetailCtrl'
      }).
      otherwise({
        redirectTo: '/services'
      });
  }]);

app.controller('ServiceListCtrl', function($scope, $log, Service) {
  $scope.services = Service.query({
    //select: ['Id', 'Title']
    filter: 'ServiceStatus eq \'Operation\' and ContentType eq \'Service\''
  });

  $scope.filters = { }; 
});

app.controller('ServiceDetailCtrl', ['$scope', '$routeParams', '$log', 'Service', function( $scope, $routeParams, $log, Service) {
  Service.query({
    //select: ['Id', 'Title']
    filter: 'Id eq ' + $routeParams.id
  }).$promise.then(function(services) {
    $scope.service = services[0];

    Service.query({
      filter: 'Klasse0 eq \'' + $scope.service.Klasse0 + '\''
    }).$promise.then(function(services) {
      $scope.similarServices = services
    });
  });

  $scope.id = $routeParams.id
}]);
