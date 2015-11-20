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

  go: (factor) ->
    @context.clearRect(-1*@canvas.width, -1*@canvas.height, 2*@canvas.width, 2*@canvas.height)
    @context.beginPath()

    points = 100
    for i in [0..points]
      endi = i * factor % points
      start = new Polar(@radius(), (i/points) * (2*Math.PI))
      end = new Polar(@radius(), (endi/points) * (2*Math.PI))

      @context.moveTo start.x(), start.y()
      @context.lineTo end.x(), end.y()

    @context.stroke()

  radius: ->
    @_radius ||= Math.floor(0.9 * Math.min(@canvas.width, @canvas.height) / 2)


this.draw = ->
  canvas = document.getElementById 'prismatron'
  return unless canvas.getContext

  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

  k = new Kaleidotron(canvas)
  indicator = document.getElementById 'indicator'

  @factor = 1

  iterate = ->
    indicator.textContent = Math.ceil(@factor * 100) / 100
    k.go @factor
    @factor = @factor + 0.01

  setInterval iterate, 10

# throttle = (type, name, obj) ->
#   obj = obj || window
#   running = false
#   func = ->
#     return if running
#     running = true
#     requestAnimationFrame ->
#       obj.dispatchEvent(new CustomEvent(name))
#       running = false

#   obj.addEventListener(type, func)

# throttle "scroll", "optimizedScroll"

# window.addEventListener "optimizedScroll", ->
#   console.log("Resource conscious scroll callback!")
