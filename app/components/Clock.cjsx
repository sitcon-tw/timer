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
      newHours: 0
      newMinutes: 0
      newSeconds: 0
    }

  getDefaultProps: ->
    {
      hours: 0
      minutes: 0
      seconds: 0
      isPause: false
      clockSetCount: 2
      fontSize: 7
    }

  _Tick: ->
    if @state.remainTime > 0
      remainTime = @state.remainTime - 1
      [hours, minutes, seconds] = @_SecondsToHuman(remainTime)

      @setState {
        remainTime: remainTime
        newHours: hours
        newMinutes: minutes
        newSeconds: seconds
      }

      @timer = setTimeout(@_Tick, 1000)
    else
      @props.onTimeout() if @props.onTimeout
      clearTimeout(@timer)

  _SecondsToHuman: (remainTime)->
    hours = Math.floor(remainTime / 3600)
    minutes = Math.floor( (remainTime % 3600) / 60 )
    seconds = (remainTime % 3600) % 60

    [hours, minutes, seconds]

  _Humanize: (usePad)->
    [@state.newHours.padLeft(2), @state.newMinutes.padLeft(2), @state.newSeconds.padLeft(2)]

  _onUpdateTime: (e) ->

    [hours, minutes, seconds] = [@state.newHours, @state.newMinutes, @state.newSeconds]

    switch e.target.name
      when "hours" then hours = Number(e.target.value) || 0
      when "minutes" then minutes = Number(e.target.value) || 0
      when "seconds" then seconds = Number(e.target.value) || 0

    countDownSeconds = hours * 3600 + minutes * 60 + seconds
    [hours, minutes, seconds] = @_SecondsToHuman(countDownSeconds)

    @setState {
      remainTime: countDownSeconds
      newHours: hours
      newMinutes: minutes
      newSeconds: seconds
    }

  getStyle: ->
    {
      fontSize: "#{@props.fontSize}em"
    }

  setTime: (hours, minutes, seconds) ->
    remainTime = hours * 3600 + minutes * 60 + seconds
    @setState {
      remainTime: remainTime
      newHours: hours
      newMinutes: minutes
      newSeconds: seconds
    }

  reset: ->
    @setState @getInitialState()

  getClockSet: ->
    clockSetCount = if @props.isPause then 3 else @props.clockSetCount
    clockSet = []
    times = []
    names = ["hours", "minutes", "seconds"]
    offset = 0
    if @props.isPause
      times = [@state.newHours.padLeft(2), @state.newMinutes.padLeft(2), @state.newSeconds.padLeft(2)]
    else
      times = @_Humanize()

    for time, key in times
      if Number(time) <= 0 and (3-key) > clockSetCount
        offset++

    for index in [1..clockSetCount]
      clockOffsetIndex = index + offset - 1
      time = times[clockOffsetIndex]
      name = names[clockOffsetIndex]
      clockSet.push(
        <input key={index} tabIndex={index} style={@getStyle()} className="clock-time" type="text" value={time} name={name} disabled={!@props.isPause} onChange={@_onUpdateTime} />
      )
      if index < clockSetCount
        clockSet.push(
          <span key={index+100} className="clock-time split" style={@getStyle()}>:</span>
        )

    clockSet

  componentWillMount: ->
    countDownSeconds = @props.hours * 3600 + @props.minutes * 60 + @props.seconds
    @setState {
      remainTime: countDownSeconds
    }

  componentDidMount: ->
    @timer = setTimeout(@_Tick, 1000)

  componentWillReceiveProps: (nextProps) ->
    clearTimeout(@timer)
    if !nextProps.isPause
      @timer = setTimeout(@_Tick, 1000)

    if nextProps.clockSetCount > 3 || nextProps.clockSetCount < 1
      nextProps.clockSetCount = 2

  componentWillUnmont: ->
    clearTimeout(@timer)

  render: ->
    (
      <div className="clock with-transition" style={@props.style}>
        {@getClockSet()}
      </div>
    )
}
