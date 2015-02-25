###
# Clock
#
# @cjsx React.DOM
###

React = require 'react'

# Extend "Number" to support "00" format
Number.prototype.padLeft = (length, padString) ->
  length ||= 1
  padString ||= "0"
  numberLength = @toString().length

  if length > numberLength
    return (new Array(length - numberLength + 1)).join(padString) + @toString()

  @toString()


module.exports = React.createClass {
  displayName: 'Clock'
  getInitialState: ->
    {
      remainTime: 0
    }

  getDefaultProps: ->
    {
      hours: 0
      minutes: 0
      seconds: 0
      isPause: false
    }

  _Tick: ->
    if @state.remainTime > 0
      @setState {
        remainTime: --@state.remainTime
      }
      @timer = setTimeout(@_Tick, 1000)
    else
      @props.onTimeout() if @props.onTimeout
      clearTimeout(@timer)


  _Humanize: ->
    hours = Math.floor(@state.remainTime / 3600)
    minutes = Math.floor( (@state.remainTime % 3600) / 60 )
    seconds = (@state.remainTime % 3600) % 60

    "#{hours.padLeft(2)}:#{minutes.padLeft(2)}:#{seconds.padLeft(2)}"

  componentWillMount: ->
    countDownSeconds = @props.hours * 3600 + @props.minutes * 60 + @props.seconds
    @setState {
      remainTime: countDownSeconds
    }

  componentDidMount: ->
    @timer = setTimeout(@_Tick, 1000)

  componentWillReceiveProps: (nextProps) ->
    if !nextProps.isPause
      setTimeout(@_Tick, 1000)
    clearTimeout(@timer)

  componentWillUnmont: ->
    clearTimeout(@timer)

  render: ->
    (
      <div>{@_Humanize()}</div>
    )
}
