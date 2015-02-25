###
# HTML Tasks
###

gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config'

gulp.task 'html', ->
  gulp.src config.html.src
      .pipe gulp.dest(config.html.devDest)
      .pipe $.size({title: 'html'})

gulp.task 'html:bundle', ->
  gulp.src config.html.src
      .pipe gulp.dest(config.html.dest)
      .pipe $.size({title: 'html'})

