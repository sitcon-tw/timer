###
# Browserify
###

gulp = require 'gulp'
gutil = require 'gulp-util'
$ = require('gulp-load-plugins')()
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
watchify = require 'watchify'
browserify = require 'browserify'

config = require '../config'

bundler = browserify(config.browserify.src, {
  extensions: ['.coffee', '.cjsx']
  debug: true
})
bundler.transform 'envify'
bundler.transform 'coffee-reactify'

gulp.task 'js', ->
  bundler.bundle()
         .on 'error', gutil.log
         .on 'error', -> @emit 'end'
         .pipe source('app.js')
         .pipe buffer()
         .pipe $.sourcemaps.init({ loadMpas: true })
         .pipe $.sourcemaps.write('./')
         .pipe gulp.dest(config.browserify.devDest)
         .pipe $.size({ title: 'js' })

gulp.task 'js:bundle', ->
  bundler.bundle()
         .on 'error', gutil.log.bind(gutil, 'browserify error')
         .pipe source('app.js')
         .pipe buffer()
         .pipe $.uglify()
         .pipe gulp.dest(config.browserify.dest)
         .pipe $.size({ title: 'js' })
