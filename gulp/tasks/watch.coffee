###
# Gulp Watch
###

gulp = require 'gulp'
browsersSync = require 'browser-sync'
reload = browsersSync.reload
config = require '../config'

$ = require('gulp-load-plugins')()

gulp.task 'watch', ['js', 'sass', 'images', 'html', 'vendor'], ->
  browsersSync {
    server: {
      baseDir: config.browserSync.baseDir
      routes: config.browserSync.routes
    }
  }

  gulp.watch config.js.src, ['js', reload]
  gulp.watch config.sass.src, ['sass', reload]
  gulp.watch config.images.src, ['images', reload]
  gulp.watch config.html.src, ['html', reload]
  gulp.watch config.vendor.src, ['vendor', reload]
