###
# Timer
#
# @cjsx React.DOM
###

React = require 'react'

Clock = require './Clock'

module.exports = React.createClass {
  displayName: 'Timer'
  getInitialState: ->
    {
      isPause: false
    }

  _Timeout: ->
    @setState { isPause: true }

  _TogglePause: ->
    @setState { isPause: !@state.isPause }

  componentDidMount: ->

  render: ->
    (
      <div>
        <Clock minutes={1} onTimeout={@_Timeout} isPause={@state.isPause} />
        <button onClick={@_TogglePause}>{if @state.isPause then "Start" else "Pause" }</button>
      </div>
    )
}
