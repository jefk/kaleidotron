class Polar
  constructor: (@radius, @radians) ->

  x: ->
    Math.cos(@radians) * @radius

  y: ->
    Math.sin(@radians) * @radius

class Kaleidotron
  constructor: (@canvas) ->
    @context ||= @canvas.getContext '2d'

  go: ->
    @context.translate @canvas.width/2, @canvas.height/2
    @context.beginPath();
    # @context.arc(0,0,200,0,Math.PI*2,true);

    for i in [0...1] by (1/100)
      p = new Polar(200, i * (2*Math.PI))
      @context.moveTo 200, 0
      @context.lineTo p.x(), p.y()

    @context.stroke();


this.draw = ->
  canvas = document.getElementById 'prismatron'
  return unless canvas.getContext

  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

  k = new Kaleidotron(canvas)
  k.go()
