/*
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/

'use strict';

// Include Gulp & tools we'll use
var gulp = require('gulp');
var changed = require('gulp-changed');
var newer = require('gulp-newer');
var filesInStream = require('gulp-filesinstream');
var watch = require('gulp-watch');

var source = 'app/**';

gulp.task('copy', function() {
  var destination = 'Z:\\SiteAssets'

  return gulp.src(source)
      //.pipe(filesInStream(null, 'org'))
      .pipe(newer(destination))
      .pipe(filesInStream(null, 'new'))
      .pipe(gulp.dest(destination));
});

gulp.task('watch', function (event) {

  gulp.watch(source, ['copy']);

});
