#+--------------------------------------------------------------------+
#| Console.coffee
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
Phaser.Game::constructor = Phaser.Game
#
# Katra Console
#

module.exports = class Console extends Phaser.Game

  constructor: () ->

    super 320, 480
    @state.add 'Boot',      require("./classes/Boot"), false
    @state.add 'Preloader', require("./classes/Preloader"), false
    @state.add 'World',     require("./classes/World"), false
    @state.start 'Boot'
