###
# Copy some files
###

gulp = require 'gulp'
gutil = require 'gulp-util'
$ = require('gulp-load-plugins')()
config = require '../config'

gulp.task 'vendor', ->
  gulp.src config.vendor.src
      .pipe gulp.dest(config.vendor.devDest)
      .pipe $.size({ title: 'vendor' })

gulp.task 'vendor:bundle', ->
  gulp.src config.vendor.src
      .pipe gulp.dest(config.vendor.dest)
      .pipe $.size({ title: 'vendor' })

