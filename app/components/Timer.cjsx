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
    }

  _Timeout: ->
    @setState { isPause: true }

  _TogglePause: ->
    @setState { isPause: !@state.isPause }

  componentDidMount: ->

  render: ->
    (
      <div>
        <Clock onTimeout={@_Timeout} isPause={@state.isPause} />
        <div className="timer-control">
          <button className="control-button" onClick={@_TogglePause}>{if @state.isPause then "開始" else "暫停" }</button>
        </div>
      </div>
    )
}
