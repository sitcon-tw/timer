###
# Bower
###

gulp = require 'gulp'
config = require '../config'
$ = require('gulp-load-plugins')()

gulp.task 'bower', ->
  $.bower()
   .pipe(gulp.dest(config.bower.dest))
