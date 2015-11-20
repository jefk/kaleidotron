class Polar
  constructor: (@radius, @radians) ->

  x: ->
    Math.cos(@radians) * @radius

  y: ->
    Math.sin(@radians) * @radius

class Kaleidotron
  constructor: (@canvas) ->
    @context = @canvas.getContext '2d'
    @context.translate @canvas.width/2, @canvas.height/2

  tau: 2*Math.PI

  go: (factor) ->
    @context.clearRect(-1*@canvas.width, -1*@canvas.height, 2*@canvas.width, 2*@canvas.height)
    @context.beginPath()

    points = 144
    for i in [1..points]
      endi = i * factor % points
      start = new Polar(@radius(), (i/points) * @tau)
      end = new Polar(@radius(), (endi/points) * @tau)

      @context.moveTo start.x(), start.y()
      @context.lineTo 3*end.x(), 3*end.y()

    @context.stroke()

  radius: ->
    @_radius ||= Math.floor(0.9 * Math.min(@canvas.width, @canvas.height) / 2)


draw = (factor = 0) ->
  # document.body.style.height = "10000px"

  canvas = document.getElementById 'prismatron'
  return unless canvas.getContext

  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

  k = new Kaleidotron(canvas)
  indicator = document.getElementById 'indicator'

  indicator.textContent = Math.ceil(factor * 100) / 100
  k.go factor

throttle = (type, name, obj) ->
  obj = obj || window
  running = false
  func = ->
    return if running
    running = true
    requestAnimationFrame ->
      obj.dispatchEvent(new CustomEvent(name))
      running = false

  obj.addEventListener(type, func)

throttle "scroll", "optimizedScroll"

scrollListener = ->
  dist = document.body.scrollTop
  pageHeight = parseInt document.body.style.height
  if not pageHeight or pageHeight - dist < 10000
    document.body.style.height = pageHeight + 10000 + "px"

  draw(document.body.scrollTop/1000)

window.addEventListener "optimizedScroll", scrollListener
window.onload = scrollListener
