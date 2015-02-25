###
# Clean Files
###

gulp = require 'gulp'
del = require 'del'
$ = require('gulp-load-plugins')()

config = require '../config'

gulp.task 'clean', ->
  gulp.src [config.tmp, config.dest], {read: false}
      .pipe $.clean()
