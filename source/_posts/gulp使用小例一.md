---
title: gulp使用小例一
category: 自动管理,gulp
tags: javascript
date: 2016-08-10
modifiedOn: 2016-08-10
---

----------
gulp的一个案例，读取指定目录中的所有文件通过gulp-filter插件进行筛选，对css、js、图片进行不同的操作

<!-- more -->

```javascript
'use strict';
var filter = require('gulp-filter');
var bytediff = require('gulp-bytediff');
var plumber = require('gulp-plumber');
var ngAnnotate = require('gulp-ng-annotate');
var uglify = require('gulp-uglify');
var ngmin = require('gulp-ngmin');
var minifyCss = require('gulp-minify-css');
var imagemin = require('gulp-imagemin');
var pngquant = require('imagemin-pngquant');
var htmlminify = require("gulp-html-minify");


module.exports = function() {
    var filterJs = filter(['**/*.js'], {restore: true});
    var filterCss = filter(['**/*.css'], {restore: true});
    var filterImg = filter(['**/*.{png,jpg,gif}'], {restore: true});
    var filterHtml = filter(['**/*.html'], {restore: true});;
    return this.gulp.src(this.opts.srcDir)
     .pipe(plumber())//防止steam报错退出
     .pipe(filterJs)//过滤出js
     .pipe(bytediff.start())//统计文件大小变化开始
     .pipe(ngAnnotate())
     .pipe(ngmin({dynamic: false}))
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
```


