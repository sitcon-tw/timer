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
      fontSize: 7
      hintMode: false
    }

  _Timeout: ->
    @setState { isPause: true, isControlOpen: true }
    @setState { hintMode: false }

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

  adjustFontSize: (adjustSize) ->
    newSize = @state.fontSize + adjustSize
    if newSize > 1
      @setState { fontSize: newSize }

  _ModifyFontSize: (e)->
    if e instanceof KeyboardEvent
      switch true
        when key.isPressed("=") || key.isPressed("+") then @adjustFontSize(1)
        when key.isPressed("_") || key.isPressed("-") then @adjustFontSize(-1)
    else
      switch e.target.name
        when "inc-font" then @adjustFontSize(1)
        when "dec-font" then @adjustFontSize(-1)

  _SetClockShow: (e) ->
    clockSetCount = 2
    switch true
      when key.isPressed("1") then clockSetCount = 1
      when key.isPressed("2") then clockSetCount = 2
      when key.isPressed("3") then clockSetCount = 3

    @setState { clockSetCount: clockSetCount }

  _IncClockSet: ->
    newSetCount = (@state.clockSetCount) % 3
    @setState { clockSetCount: newSetCount + 1 }

  _ToggleHintMode: (e) ->
    if !@state.isPause
      @setState { hintMode: !@state.hintMode }
      @refs.hint.getDOMNode().focus()
      @refs.hint.getDOMNode().value = ""

  _HandleHintKey: (e) ->
    if e.key == "Enter"
      @_ToggleHintMode()

  _SetTime: (e) ->
    time = 0
    @refs.clock.reset()
    if e instanceof KeyboardEvent

    else
      time = Number(e.target.name.replace("min", "")) || 0
      @setState {
        isPause: true
      }

    @refs.clock.setTime(0, time, 0)

  componentDidMount: ->
    key('shift+c', @_ToggleController)
    key('shift+-, shift+=', @_ModifyFontSize)
    key('space, shift+P', @_TogglePause)
    key('shift+R', @_Reset)
    key('shift+1, shift+2, shift+3', @_SetClockShow)
    key('enter', @_ToggleHintMode)

  componentWillUnMount: ->
    key.unbind('shift+c')
    key.unbind('shift+-, shift+=')
    key.unbind('space, shift+P')
    key.unbind('shift+R')
    key.unbind('shift+1, shift+2, shift+3')
    key.unbind('enter')

  render: ->
    clockStyle = { display: if @state.hintMode then 'none' else 'block' }
    hintStyle = { fontSize: "#{@state.fontSize}em", display: if @state.hintMode then 'block' else 'none' }
    [hours, minutes, seconds] = [@state.hours, @state.minutes, @state.seconds]
    (
      <div>
        <div id="timer">
          <Clock onTimeout={@_Timeout} clockSetCount={@state.clockSetCount} isPause={@state.isPause} fontSize={@state.fontSize} ref="clock" />
          <input ref="hint" className="timer-hint" style={hintStyle} onKeyDown={@_HandleHintKey} />
        </div>
        <div style={@_ControllerStyle()} className="timer-control with-transition ease-out and-fast">
          <button className="control-button" onClick={@_TogglePause}>{if @state.isPause then "開始" else "暫停" }</button>
          <button className="control-button" onClick={@_Reset}>重設</button>
          <button className="control-button" onClick={@_IncClockSet}>顯示 {@state.clockSetCount} 位</button>
          <button className="control-button" name="inc-font" onClick={@_ModifyFontSize}>放大</button>
          <button className="control-button" name="dec-font" onClick={@_ModifyFontSize}>縮小</button>
          <button className="control-button" name="10min" onClick={@_SetTime}>10 分鐘</button>
          <button className="control-button" name="40min" onClick={@_SetTime}>40 分鐘</button>
        </div>
      </div>
    )
}
