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
  # load all the assets
  #
  preload: () ->

    @load.image 'sky', 'assets/sky.png'
    @load.image 'ground', 'assets/platform.png'
    @load.image 'star', 'assets/star.png'
    @load.spritesheet 'dude', 'assets/dude.png', 32, 48

  #
  #  loading...
  #
  create: () ->

    @game.state.start 'World', true, false

