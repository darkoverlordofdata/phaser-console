#+--------------------------------------------------------------------+
#| console.coffee
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
# Katra Console
#
Phaser.Game::constructor = Phaser.Game    # patch prototype
Phaser.State::constructor = Phaser.State  # patch prototype

#
# Console application
#
class Console extends Phaser.Game

  constructor: ->

    super 320, 480
    @state.add 'Boot',      Boot, false
    @state.add 'Preloader', Preloader, false
    @state.start 'Boot'

#
# Boot - starts the application
#
class Boot extends Phaser.State

  #
  # Preload application resources
  #
  preload: ->
    @load.image 'background', 'assets/background.jpg'

  #
  # Initialize the application
  #
  create: ->
    @input.maxPointers = 1
    @stage.scaleMode = if @game.device.desktop then Phaser.StageScaleMode.SHOW_ALL else Phaser.StageScaleMode.EXACT_FIT
    @stage.scale.maxWidth = null
    @stage.scale.maxHeight = null
    @stage.disableVisibilityChange = true
    @stage.disablePauseScreen = true
    @stage.scale.pageAlignHorizontally = true
    @stage.scale.setScreenSize()
    @game.state.start 'Preloader'

#
# Preloader - loads the application assets
#
class Preloader extends Phaser.State

  preloadBar: Phaser.Sprite

  #
  # load all the assets
  #
  preload: () ->

    @preloadBar = @add.sprite(200, 250, 'preloadBar')
    @load.setPreloadSprite @preloadBar

  #
  #  loading...
  #
  create: () ->

    tween = @add.tween(@preloadBar).to({ alpha: 0 }, 1000, Phaser.Easing.Linear.None, true)
    tween.onComplete.add @startMainMenu, @


  startMainMenu: () ->

    @game.state.start 'MainMenu', true, false



new Console