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
      clockSetCount: 2
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

  _ModifyFontSize: (e)->
    switch true
      when key.isPressed("=") || key.isPressed("+") then @refs.clock.adjustFontSize(1)
      when key.isPressed("_") || key.isPressed("-") then @refs.clock.adjustFontSize(-1)

  _SetClockShow: (e) ->
    clockSetCount = 2
    switch true
      when key.isPressed("1") then clockSetCount = 1
      when key.isPressed("2") then clockSetCount = 2
      when key.isPressed("3") then clockSetCount = 3

    @setState { clockSetCount: clockSetCount }

  componentDidMount: ->
    key('shift+c', @_ToggleController)
    key('shift+-, shift+=', @_ModifyFontSize)
    key('space, shift+P', @_TogglePause)
    key('shift+R', @_Reset)
    key('shift+1, shift+2, shift+3', @_SetClockShow)

  componentWillUnMount: ->
    key.unbind('shift+c')
    key.unbind('shift+-, shift+=')
    key.unbind('space, shift+P')
    key.unbind('shift+R')
    key.unbind('shift+1, shift+2, shift+3')

  render: ->
    [hours, minutes, seconds] = [@state.hours, @state.minutes, @state.seconds]
    (
      <div>
        <div id="timer">
          <Clock onTimeout={@_Timeout} clockSetCount={@state.clockSetCount} isPause={@state.isPause} ref="clock" />
        </div>
        <div style={@_ControllerStyle()} className="timer-control with-transition ease-out and-fast">
          <button className="control-button" onClick={@_TogglePause}>{if @state.isPause then "開始" else "暫停" }</button>
          <button className="control-button" onClick={@_Reset}>重設</button>
        </div>
      </div>
    )
}
