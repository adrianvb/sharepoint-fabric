'use strict';

var app = angular.module('servicesApp', [
  'ExpertsInside.SharePoint.List',
  'ngRoute',
  'angular.filter'
]);

app.factory('Service', function($spList) {
  return $spList('Services');
});

app.config(
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
    }
);

app.config(function($locationProvider)  {
    //$locationProvider.html5Mode(true);
});

app.directive('serviceField', function() {
  return {
    restrict: 'E',
    scope: {
      field: '=field',
      label: '=label',
      renderAs: '=renderAs'
    },
    templateUrl: 'templates/services/field.html'

  };
});

app.directive('serviceListitem', function() {

    return {
        restrict: 'E',
        scope: {
            primary: '=primary',
            secondary: '=secondary',
            tertiary: '=tertiary',
            meta: '=meta'
        },

        templateUrl: 'templates/services/service-listitem.html',

        link: function($scope) {
            $scope.toggleDescription = function($event) {
                $scope.showDescription = !$scope.showDescription;
                $event.stopPropagation();
            };
        }
    };
});

app.directive('serviceDetail', function(Service) {

    return {
        restrict: 'E',
        scope: {
            service: '=service'
        },

        templateUrl: 'templates/services/service-detail.html',

        link: function($scope) {
            $scope.service.$promise.then(function() {
                var filter =  'Klasse0 eq \'' + $scope.service.Klasse0 + '\'';
                    filter += 'and ServiceStatus ne \'Retired\'';

                $scope.similarServices = Service.query({
                    filter: filter,
                    orderby: 'Title'
                });
            });
        }
    };
});

app.controller('ServiceListCtrl', function($scope, $log, $window, $location, Service) {
  $scope.services = Service.query({
    //select: ['Id', 'Title']
    orderby: 'Title',
    filter: 'ServiceStatus eq \'Operation\' and ContentType eq \'Service\''
  });
  $scope.count = 0;
  $scope.filters = { };

  $scope.OpenDetailView = function(serviceId) {
      $location.url('/services/' + serviceId);
  }
});



app.controller('ServiceDetailCtrl', function( $scope, $routeParams, $log, $filter, Service) {
    $scope.service = Service.get($routeParams.id);

    $scope.id = $routeParams.id
});
