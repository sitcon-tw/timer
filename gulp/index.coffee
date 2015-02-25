###
# Gulp
###

fs = require 'fs'
path = require 'path'

# Load Gulp tasks
fs.readdirSync './gulp/tasks'
  .filter (name) ->
    /(\.(coffee|js)$)/i.test(path.extname(name))
  .forEach (task) ->
    require('./tasks/' + task)



