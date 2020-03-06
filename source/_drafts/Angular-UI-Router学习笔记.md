---
title: Angular-UI-Router 学习笔记
category: angularjs
tags: angularjs
toc: true
abbrlink: 204a45e
date: 2016-08-03 00:00:00
modifiedOn: 2016-08-03 00:00:00
---

----------
路由 Route
=============

## 为什么用 Route

 - AJAX 请求不会留下 History 记录
 - 用户无法直接通过 URL进入应用中的指定页面(保存书签、链接分享给朋友)
 - AJAX 对 SEO 是个灾难

```
var bookStoreApp = angular.module('bookStoreApp', [
    'ngRoute', 
    'ngAnimate', 
    'bookStoreCtrls', 
    'bookStoreFilters',
    'bookStoreServices', 
    'bookStoreDirectives'
]);
bookStoreApp.config(
    // 路由机制
    function($routeProvider) {
        $routeProvider.when('/hello', {
            templateUrl: 'tpls/hello.html',
            controller: 'HelloCtrl'
        }).when('/list/:bookId', {
            templateUrl: 'tpls/bookList.html',
            constoller: 'BookListCtrl'
        }).otherwise({
            redirectTo: '/hello'
        });
    }
);
```
## 嵌套 View (Nested Routing for AngularJS)
### AngularUI-Router AngularUI
```
<div ui-view></div>
```
## 前端路由的基本原理
 - 哈希 #
 - HTML5 中新的 history API
 - 路由的核心是给应用定义 "状态"
 - 使用路由机制会影响到应用的整体编码方式(需预先定义好状态)
 - 考虑兼容性问题与 "优雅降级"

## Angular-UI-Router
### ui-sref 指令链接到特定状态
```
<a ui-sref="home">Home</a>
<a ui-sref="about">About</a>
<a ui-sref="contacts.list">Contacts</a>
```
### $state.includes 返回 *true* / *false*
以上方法为查看当前状态是否在某父状态内，比如 *$state.includes('contacts')* 返回 *true* / *false*

```
<!-- 包含在 /contacts 状态内部，即其作为 parant state -->
<li ng-class="{active: $state.includes('contacts')}">
    <a ui-serif="contacts.list">Contacts</a>
</li>
```
### ui-sref-active 查看当前激活状态并设置 *Class*
```
<li ui-sref-active="active"><a ui-sref="about">About</a></li>
```
### 包含模块
```
angular.module('uiRouter', ['ui.router']);
```
### 方便获得当前状态的方法，绑到根作用域
```
app.run(['$rootScope', '$state', '$stateParams',
    function($rootScope, $state, $stateParams) {
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
    }
]);
```
### 路由重定向 *$urlRouterProvider*
```
app.config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {
        $urlRouterProvider
            // 错误的路由重定向
            .when('/c?id', '/contacts/:id')
            .when('/user/:id', '/contacts/:id')
            .otherwise('/');
    }
]);
```
### 状态配置
```
$stateProvider.
    state('about', {
        url: '/about',
        template: '<h1>Welcome to UI-Router Demo</h1>',

        // optional below
        templateProvider: ['$timeout',
            function($timeout) {
                return $timeout(function() {
                    return '<p class="lead">UI-Router Resource</p>' +
                            '<p>The second line</p>'
                }, 100);
            }
        ],

        templateUrl: 'about.html',

        templateUrl: function() {
            return 'about.html';
        },

        controller: 'UIRouterCtrl',

        // below is a state controller picked from UI-Router official sample
        controller: ['$scope', '$state', 'contacts', 'utils',
            function ($scope, $state, contacts, utils) {
                $scope.contacts = contacts;

                $scope.goToRandom = function () {
                    var randId = utils.newRandomKey($scope.contacts, 'id', $state.params.contactId);

                    $state.go('contacts.details', { contactId: randId });
                }
            }
        ]
    });
```

### 嵌套配置 Configure

##### Parent Router
```
$stateProvider.
    .state('contacts', {

        // abstract: true 表明此状态不能被显性激活，只能被子状态隐性激活
        abstract: true,
        url: '/contacts',
        templateUrl: 'contacts.html',

        // resolve 被使用来处理异步数据调用，以下是返回一个 promise -> contacts.all()
        resolve: {
            contacts: ['contacts',
                function(contacts) {
                    // 以下方法被放在 contacts.service.js 中，以 factory 存在
                    return contacts.all();
                }
            ]
        },

        // below is a state controller picked from UI-Router official sample
        controller: ['$scope', '$state', 'contacts', 'utils',
            function ($scope, $state, contacts, utils) {
                $scope.contacts = contacts;

                $scope.goToRandom = function () {
                    var randId = utils.newRandomKey($scope.contacts, 'id', $state.params.contactId);

                    $state.go('contacts.details', { contactId: randId });
                }
            }
        ]
    })

```
##### Children Router (Nested Router)
```
$stateProvider
    .state('contacts.list', {
        url: '',
        templateUrl: 'contacts.list.html'
    })

    .state('contacts.detail', {
        url: '/{contactId:[0-9]{1,4}}',

        // view 用在该状态下有多个 ui-view 的情况，可以对不同的 ui-view 使用特定的 template, controller, resolve data
        // 绝对 view 使用 '@' 符号来区别，比如 'foo@bar' 表明名为 'foo' 的 ui-view 使用了 'bar' 状态的模板(template)，相对 view 则无
        views: {
            // 无名 view
            '': {
                templateUrl: 'contacts.detail.html',
                controller: ['$scope', '$stateParams', 'utils',
                    function ($scope, $stateParams, utils) {
                        $scope.contact = utils.findById($scope.contacts, $stateParams.contactId);
                    }
                ]
            },

            // for "ui-view='hint'"
            'hint@': {
                template: 'This is contacts.defail populating the "hint" ui-view'
            },
            
            // for "ui-view='menuTip'"
            'menuTip': {
                templateProvider: ['$stateParams',
                    function($stateParams) {
                        return '<hr><small class="muted">Contact ID: ' + $stateParams.contactId + '</small>';
                    }
                ]
            }
        }
    })
```
HTML Codes
```

<h2>All Contacts</h2>
<ul>
  <li ng-repeat="contact in contacts">
    <a ui-sref="contacts.detail({contactId:contact.id})">{{contact.name}}</a>
  </li>
</ul>

```

