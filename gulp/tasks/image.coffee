###
# Minify image
###

gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config'

gulp.task 'images', ->
  gulp.src config.images.src
      .pipe $.cache($.imagemin({
        progressive: true
        interlaced: true
      }))
      .pipe gulp.dest config.images.devDest
      .pipe $.size({ title: 'images' })

gulp.task 'images:bundle', ->
  gulp.src config.images.src
      .pipe $.imagemin {
        progressive: true
        interlaced: true
      }
      .pipe gulp.dest config.images.dest
      .pipe $.size({ title: 'images' })

