###
# Timer Application
###

React = require 'react'
Timer = require './components/Timer'

window.onload = ->
  React.render <Timer />, document.body
