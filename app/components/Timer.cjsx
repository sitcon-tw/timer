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
      isPause: true
      isControlOpen: false
    }

  _Timeout: ->
    @setState { isPause: true, isControlOpen: true }

  _TogglePause: ->
    @setState { isPause: !@state.isPause, isControlOpen: false }

  _ControllerStyle: ->
    {
      position: "fixed"
      left: 0
      bottom: 0
      right: 0
      transform: if @state.isControlOpen then 'translateY(0%)' else 'translateY(100%)'
    }

  _ToggleController: (e) ->
    @setState { isControlOpen: !@state.isControlOpen }

  _Reset: ->
    @refs.clock.reset()

  componentDidMount: ->
    key('shift+c', @_ToggleController)

  componentWillUnMount: ->
    key.unbind('shift+c')

  render: ->
    [hours, minutes, seconds] = [@state.hours, @state.minutes, @state.seconds]
    (
      <div>
        <div id="timer">
          <Clock onTimeout={@_Timeout} isPause={@state.isPause} ref="clock" />
        </div>
        <div style={@_ControllerStyle()} className="timer-control with-transition ease-out and-fast">
          <button className="control-button" onClick={@_TogglePause}>{if @state.isPause then "開始" else "暫停" }</button>
          <button className="control-button" onClick={@_Reset}>重設</button>
        </div>
      </div>
    )
}
