---
title: gulp使用小例一
category: 自动管理,gulp
tags: javascript
date: 2016-08-10
modifiedOn: 2016-08-10
---

----------
gulp的一个案例，主要是对gulpfile.js中的任务进行分割，完成清理、文件复制同时进行筛选压缩、以及html中js和css引用的替换等

<!-- more -->

#### gulpfile.js

```javascript
'use strict';
var gulp = require('gulp');
var config = {
    pkg: require('./package.json'),
    publicDir: ['./{public,public/**}'],
    resourcesDir: ['./{resources/,resources/**}'],
    apps: ['ads', 'analysis', 'homepage', 'index', 'manage', 'portrait', 'recommend'],
    destDir: 'dest',
    version: "0.01"
};

// load plugins
require('gulp-task-loader')(config);
gulp.task('build', ['clean', 'copy', 'app-concat', 'vendor-concat', 'html-replace']);

```
**gulp-task-loader**插件默认会寻找**gulp-tasks**目录下的任务

#### clean.js
```javascript
'use strict';
var del = require('del');

module.exports = function() {
    return del.sync(this.opts.destDir);
};
```

#### copy.js

```javascript
'use strict';
var filter = require('gulp-filter');
var gulpIgnore = require('gulp-ignore');
var bytediff = require('gulp-bytediff');
var plumber = require('gulp-plumber');
var uglify = require('gulp-uglify');
var minifyCss = require('gulp-minify-css');
var imagemin = require('gulp-imagemin');
var pngquant = require('imagemin-pngquant');
var htmlminify = require("gulp-html-minify");


module.exports = function() {
    var excludeJs = [];
    this.opts.apps.forEach(function(item){
        excludeJs.push('**/'+item+'/js/{**,*.*}');
        excludeJs.push('!**/'+item+'/js/partials/{**,*.*}');
    });
    excludeJs.push('**/js/{**,*.*}');
    excludeJs.push('!**/js/i18n/{**,*.*}');
    excludeJs.push('!**/js/server/{**,*.*}');
    excludeJs.push('!**/js/zeroclipboard/{**,*.*}');
    excludeJs.push('!**/js/layer/{**,*.*}');
    excludeJs.push('!**/js/My97DatePicker/{**,*.*}');
    excludeJs.push('!**/js/echarts/province.min.js');
    
    var filterJs = filter(['**/*.js'], {restore: true});
    var filterCss = filter(['**/*.css'], {restore: true});
    var filterImg = filter(['**/*.{png,jpg,gif}'], {restore: true});
    var filterHtml = filter(['**/*.html'], {restore: true});

    return this.gulp.src(this.opts.publicDir)
     .pipe(plumber())//防止steam报错退出
     .pipe(gulpIgnore.exclude(excludeJs))

     .pipe(filterJs)//过滤出js
     .pipe(bytediff.start())//统计文件大小变化开始
     .pipe(uglify())//压缩js
     .pipe(bytediff.stop())//统计文件大小变化开始
     .pipe(filterJs.restore)
     .pipe(filterImg)//过滤出图片
     .pipe(bytediff.start())
     .pipe(imagemin({ 
         progressive: true,//类型：Boolean 默认：false 无损压缩jpg图片
         svgoPlugins: [{removeViewBox: false}],//不要移除svg的viewbox属性
         use: [pngquant()] //使用pngquant深度压缩png图片的imagemin插件
     }))
     .pipe(bytediff.stop())
     .pipe(filterImg.restore)
     .pipe(filterCss)//过滤出css
     .pipe(bytediff.start())
     .pipe(minifyCss())//压缩
     .pipe(bytediff.stop())
     .pipe(filterCss.restore)
     .pipe(filterHtml)//过滤出html
     .pipe(bytediff.start())
     .pipe(htmlminify())//压缩
     .pipe(bytediff.stop())
     .pipe(filterHtml.restore)
     .pipe(this.gulp.dest(this.opts.destDir));
};
module.exports.dependencies = ['clean'];
```
#### app-concat.js

```javascript
'use strict';
var fs = require('fs');
var path = require('path');
var merge = require('merge-stream');
var fileconcat = require('gulp-file-concat');
var uglify = require('gulp-uglify');
var ngAnnotate = require('gulp-ng-annotate');
var rename = require('gulp-rename');

module.exports = function() {
    var gulp = this.gulp;
    var opts = this.opts;
    var apps = this.opts.apps;
    
    var tasks = apps.map(function(app) {
      return gulp.src(path.join('public', app, 'js', 'app_maps.js'))
        .pipe(fileconcat({
            relativeUrls: './public'
        }))
        .pipe(ngAnnotate())
        .pipe(uglify())
        .pipe(rename(function(path){
            path.basename = 'app';
            path.extname = '.js'
        }))
        .pipe(gulp.dest(path.join(opts.destDir, 'public', app , 'js')));
   });

   return merge(tasks);
};
module.exports.dependencies = ['copy'];
```
**这里会循环gulpfile.js中的apps这个配置，然后去寻找相应目录下的app_maps.js文件，然后进行合并压缩，app_maps.js文件如下：**
```javascript
document.write('<script src="/analysis/js/app.js"></script>');
document.write('<script src="/analysis/js/commom.js"></script>');

document.close();
```

**都是些自己写的js文件**

#### vendor-concat.js

```javascript
'use strict';
var fs = require('fs');
var path = require('path');
var fileconcat = require('gulp-file-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

module.exports = function() {
    var gulp = this.gulp;
    var opts = this.opts;
    
    return gulp.src(path.join('public', 'js', 'vendor.map.js'))
        .pipe(fileconcat({
            relativeUrls: './public'
        }))
        .pipe(uglify())
        .pipe(rename(function(path){
            path.basename = 'vendor';
            path.extname = '.js'
        }))
        .pipe(gulp.dest(path.join(opts.destDir, 'public', 'js')));
};
module.exports.dependencies = ['app-concat'];
```

vendor.map.js

```javascript
document.write('<script src="/js/jquery/jquery.min.js"></script>');
document.write('<script src="/js/bootstrap/bootstrap.min.js"></script>');

document.close();

```

**没什么好解释的，都是一些依赖的库**

#### html-replace.js

```javascript
'use strict';
var fs = require('fs');
var path = require('path');
var htmlreplace = require('gulp-html-replace');

module.exports = function() {
    var gulp = this.gulp;
    var opts = this.opts;
    var apps = opts.apps;

    var replace_res = {
        //'css': 'styles.min.css?ver='+opts.version,
        'vendorJs': '/js/vendor.js?ver='+opts.version
    };

    apps.forEach(function(app){
        replace_res[app] = '/' + app + '/js/app.js?ver='+opts.version
    });

    return gulp.src(opts.resourcesDir)
      .pipe(htmlreplace(replace_res))
      .pipe(gulp.dest(path.join(opts.destDir, 'resources')));
};
module.exports.dependencies = ['vendor-concat'];
```

**html页面**
```html
    <!-- build:vendorJs -->
    <script src="/js/vendor.map.js"></script>
    <!-- endbuild -->
    <script src="/js/zeroclipboard/ZeroClipboard.js"></script>
    <script src="/js/layer/layer.js"></script>
    <!-- build:manage -->
    <script src="/manage/js/app_maps.js"></script>
    <!-- endbuild -->
```

**这里就是html中的js和css文件替换**

执行`gulp build`就可以见证奇迹了



