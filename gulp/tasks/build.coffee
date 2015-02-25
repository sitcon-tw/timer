###
# Bundle All files
###

gulp = require 'gulp'
$ = require('gulp-load-plugins')()

gulp.task 'bundle', ['js:bundle', 'sass:bundle', 'images:bundle', 'html:bundle', 'vendor:bundle', 'bower']
