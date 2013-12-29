#+--------------------------------------------------------------------+
#| Preloader.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2013
#+--------------------------------------------------------------------+
#|
#| This file is a part of Katra-Console
#|
#| Katra-Console is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# patch:
#
Phaser.State::constructor = Phaser.State

#
# Preloader - loads the application assets
#
module.exports = class Preloader extends Phaser.State

  #
  #  loading...
  #
  preload: () ->

    @load.image 'sky', 'assets/sky.png'
    @load.image 'ground', 'assets/platform.png'
    @load.image 'star', 'assets/star.png'
    @load.spritesheet 'dude', 'assets/dude.png', 32, 48

  #
  #  loaded.
  #
  create: () ->

    @game.state.start 'World', true, false

  #
  #  draw a progress bar
  #
  loadRender: () ->

    invMul = @game.stage.bounds.width / @game.stage.scale.width
    W = 138 * invMul
    H = 20 * invMul
    X = (@game.stage.bounds.width - W) / 2
    Y = (@game.stage.bounds.height - H) / 2

    g = @game.add.graphics(0,0)
    g.beginFill 0xffffff, 1
    g.drawRect X, Y, W, H
    g.endFill()
    g.beginFill 0xfec80e, 1
    g.drawRect X, Y, W * @game.load.progress / 100, H
    g.endFill()

