#+--------------------------------------------------------------------+
#| Boot.coffee
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
# Boot - starts the application
#
module.exports = class Boot extends Phaser.State

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

