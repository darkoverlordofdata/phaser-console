// Generated by CoffeeScript 1.6.3
(function() {
  var Game, Stage, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Phaser.Game.prototype.constructor = Phaser.Game;

  Phaser.State.prototype.constructor = Phaser.State;

  Game = (function(_super) {
    __extends(Game, _super);

    function Game() {
      Game.__super__.constructor.call(this, 800, 600, Phaser.AUTO);
      this.state.add('Stage', Stage, false);
      this.state.start('Stage');
    }

    return Game;

  })(Phaser.Game);

  Stage = (function(_super) {
    __extends(Stage, _super);

    function Stage() {
      _ref = Stage.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Stage.prototype.player = null;

    Stage.prototype.platforms = null;

    Stage.prototype.cursors = null;

    Stage.prototype.stars = null;

    Stage.prototype.score = 0;

    Stage.prototype.scoreText = null;

    Stage.prototype.preload = function() {
      this.load.image('sky', 'assets/sky.png');
      this.load.image('ground', 'assets/platform.png');
      this.load.image('star', 'assets/star.png');
      return this.load.spritesheet('dude', 'assets/dude.png', 32, 48);
    };

    Stage.prototype.create = function() {
      var ground, i, ledge, star, _i;
      this.add.sprite(0, 0, 'sky');
      this.platforms = this.add.group();
      ground = this.platforms.create(0, this.world.height - 64, 'ground');
      ground.scale.setTo(2, 2);
      ground.body.immovable = true;
      ledge = this.platforms.create(400, 400, 'ground');
      ledge.body.immovable = true;
      ledge = this.platforms.create(-150, 250, 'ground');
      ledge.body.immovable = true;
      this.player = this.add.sprite(32, this.world.height - 150, 'dude');
      this.player.body.bounce.y = 0.2;
      this.player.body.gravity.y = 6;
      this.player.body.collideWorldBounds = true;
      this.player.animations.add('left', [0, 1, 2, 3], 10, true);
      this.player.animations.add('right', [5, 6, 7, 8], 10, true);
      this.stars = this.add.group();
      for (i = _i = 0; _i < 12; i = ++_i) {
        star = this.stars.create(i * 70, 0, 'star');
        star.body.gravity.y = 6;
        star.body.bounce.y = 0.7 + Math.random() * 0.2;
      }
      this.scoreText = this.add.text(16, 16, 'score: 0', {
        fontSize: '32px',
        fill: '#000'
      });
      return this.cursors = this.input.keyboard.createCursorKeys();
    };

    Stage.prototype.update = function() {
      this.physics.collide(this.player, this.platforms);
      this.physics.collide(this.stars, this.platforms);
      this.physics.overlap(this.player, this.stars, this.collectStar, null, this);
      this.player.body.velocity.x = 0;
      if (this.cursors.left.isDown) {
        this.player.body.velocity.x = -150;
        this.player.animations.play('left');
      } else if (this.cursors.right.isDown) {
        this.player.body.velocity.x = 150;
        this.player.animations.play('right');
      } else {
        this.player.animations.stop();
        this.player.frame = 4;
      }
      if (this.cursors.up.isDown && this.player.body.touching.down) {
        return this.player.body.velocity.y = -350;
      }
    };

    Stage.prototype.collectStar = function(player, star) {
      star.kill();
      this.score += 10;
      return this.scoreText.content = 'Score: ' + this.score;
    };

    return Stage;

  })(Phaser.State);

  new Game;

}).call(this);
