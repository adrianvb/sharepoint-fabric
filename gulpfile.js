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
var gulpBowerFiles = require('main-bower-files');
var jslint = require('gulp-jslint');
var rimraf = require('gulp-rimraf');

var source = 'app/**';

gulp.task('copy-to-sharepoint', function() {
  var destination = 'Z:\\SiteAssets';
  destination = '/Volumes/gulp/SiteAssets/';

  return gulp.src('dist/**')
      //.pipe(filesInStream(null, 'org'))
      .pipe(newer(destination))
      .pipe(filesInStream(null, 'copy-to-sharepoint'))
      .pipe(gulp.dest(destination));
});

gulp.task('clean', function(cb) {
/*  gulp.src('dist', { read: false })
    .pipe(rimraf());
*/
});

gulp.task("prepare-app", function() {
  gulp.src(source)
    .pipe(gulp.dest('dist'))
});

gulp.task('scripts', function() {
  gulp.src(['dist/**/.js', '!dist/vendor/*.js'])
    .pipe(jslint)
});

gulp.task("bower-files", function(){
    gulp.src(gulpBowerFiles())
      .pipe(newer('dist/vendor'))
      .pipe(filesInStream(null, 'vendor'))
      .pipe(gulp.dest('dist/vendor'));
});

gulp.task('default', ['clean', 'prepare-app', 'bower-files', 'copy-to-sharepoint'], function() {});

gulp.task('watch', function (event) {
  gulp.watch(source, ['default']);
});
