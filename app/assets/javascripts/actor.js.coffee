class Actor
  constructor: (@game, @sprite, coords = { x: 0, y: 0 }) ->
    @x = coords.x
    @y = coords.y
    @is_alive = true
    @remove_from_world = false

    Actor.count++
    # console.log "[new] Actor [#{Actor.count}]"
    gb.addEntity this

  update: ->
    null

  draw: (context) ->
    if @game.showOutlines && @radius
      context.beginPath();
      context.strokeStyle = "green";
      context.arc(@x, @y, @radius, 0, Math.PI*2, false);
      context.stroke();
      context.closePath();

  drawSpriteCentered: (ctx) ->
    x = @x - @sprite.width/2
    y = @y - @sprite.height/2
    gb.context.drawImage(@sprite, x, y)

  drawSpriteCenteredRotated: (context) ->
    context.save()
    context.translate @x, @y
    context.rotate @angle + Math.PI/2
    context.drawImage @sprite, -@sprite.width/2, -@sprite.height/2
    context.restore()

  rotateAndCache: (image) ->
    offscreenCanvas = document.createElement 'canvas'
    size            = Math.max image.width, image.height
    offscreenCanvas.width  = size
    offscreenCanvas.height = size
    offscreenCtx           = offscreenCanvas.getContext '2d'
    offscreenCtx.translate size/2, size/2
    offscreenCtx.rotate @angle + Math.PI/2
    offscreenCtx.drawImage image, -(image.width/2), -(image.height/2)
    offscreenCanvas

  outsideScreen: ->
    (@x > @game.halfSurfaceWidth || @x < -(@game.halfSurfaceWidth) || @y > @game.halfSurfaceHeight || @y < -(@game.halfSurfaceHeight))

  @count: 0

class SpaceShip extends Actor
  enjoy: ->
    console.log 'enjoying...'