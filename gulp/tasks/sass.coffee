###
# Handle SASS files
###

gulp = require 'gulp'
gutil = require 'gulp-util'
$ = require('gulp-load-plugins')()
config = require '../config'

gulp.task 'sass', ->
  gulp.src config.sass.src
      .pipe $.sass({
        includePaths: config.sass.includePaths
        imagePath: config.sass.imagePath
      })
      .on 'error', gutil.log
      .on 'error', -> @emit 'end'
      .pipe $.sourcemaps.init()
      .pipe $.autoprefixer()
      .pipe $.sourcemaps.write()
      .pipe gulp.dest(config.sass.devDest)
      .pipe $.size({ title: 'sass' })

gulp.task 'sass:bundle', ->
  gulp.src config.sass.src
      .pipe $.sass({
        includePaths: config.sass.includePaths
        imagePath: config.sass.imagePath
        outputStyle: 'compressed'
      })
      .on 'error', gutil.log
      .pipe $.autoprefixer()
      .pipe gulp.dest(config.sass.dest)
      .pipe $.size({ title: 'sass' })

