
Phaser.Game::constructor = Phaser.Game    # patch prototype
Phaser.State::constructor = Phaser.State  # patch prototype

class Game extends Phaser.Game

  constructor: ->

    super 800, 600, Phaser.AUTO
    @state.add 'Stage', Stage, false
    @state.start 'Stage'

class Stage extends Phaser.State

  player: null
  platforms: null
  cursors: null
  
  stars: null
  score: 0
  scoreText: null

  preload: ->

    @load.image 'sky', 'assets/sky.png'
    @load.image 'ground', 'assets/platform.png'
    @load.image 'star', 'assets/star.png'
    @load.spritesheet 'dude', 'assets/dude.png', 32, 48


  create: ->
    
    #  A simple background for our game
    @add.sprite  0, 0, 'sky'

    #  The platforms group contains the ground and the 2 ledges we can jump on
    @platforms = @add.group()

    # Here we create the ground.
    ground = @platforms.create(0, @world.height - 64, 'ground')

    #  Scale it to fit the width of the game (the original sprite is 400x32 in size)
    ground.scale.setTo 2, 2

    #  @ stops it from falling away when you jump on it
    ground.body.immovable = true

    #  Now let's create two ledges
    ledge = @platforms.create(400, 400, 'ground')
    ledge.body.immovable = true

    ledge = @platforms.create(-150, 250, 'ground')
    ledge.body.immovable = true

    # The player and its settings
    @player = @add.sprite(32, @world.height - 150, 'dude')

    #  Player physics properties. Give the little guy a slight bounce.
    @player.body.bounce.y = 0.2
    @player.body.gravity.y = 6
    @player.body.collideWorldBounds = true

    #  Our two animations, walking left and right.
    @player.animations.add 'left', [0, 1, 2, 3], 10, true
    @player.animations.add 'right', [5, 6, 7, 8], 10, true

    #  Finally some stars to collect
    @stars = @add.group()

    #  Here we'll create 12 of them evenly spaced apart
    for i in [0...12]
    #  Create a star inside of the 'stars' group
      star = @stars.create(i * 70, 0, 'star')

      #  Let gravity do its thing
      star.body.gravity.y = 6

      #  @ just gives each star a slightly random bounce value
      star.body.bounce.y = 0.7 + Math.random() * 0.2

    #  The score
    @scoreText = @add.text(16, 16, 'score: 0', fontSize: '32px', fill: '#000')

    #  Our controls.
    @cursors = @input.keyboard.createCursorKeys()



  update: ->

    #  Collide the player and the stars with the platforms
    @physics.collide @player, @platforms
    @physics.collide @stars, @platforms

    #  Checks to see if the player overlaps with any of the stars, if he does call the collectStar function
    @physics.overlap @player, @stars, @collectStar, null, @

    #  Reset the players velocity (movement)
    @player.body.velocity.x = 0

    if @cursors.left.isDown
      #  Move to the left
      @player.body.velocity.x = -150
  
      @player.animations.play 'left'

    else if @cursors.right.isDown
      #  Move to the right
      @player.body.velocity.x = 150
  
      @player.animations.play 'right'

    else
      #  Stand still
      @player.animations.stop()
  
      @player.frame = 4

    #  Allow the player to jump if they are touching the ground.
    if  @cursors.up.isDown and @player.body.touching.down
      @player.body.velocity.y = -350

  collectStar: (player, star) ->

    # Removes the star from the screen
    star.kill()

    #  Add and update the score
    @score += 10
    @scoreText.content = 'Score: ' + @score
  
new Game