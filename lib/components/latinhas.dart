import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:tiro_latinhas/myGame.dart';
import 'package:flame/flame.dart';

class Latinhas {
  Rect latinhaRect;
  final MyGame game;
  List<Sprite> latinhaSprite;
  Sprite deadSprite;
  double latinhaSpriteIndex = 0;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;

  double get speed => game.tileSize * 3;

  Latinhas(this.game) {
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() *
        (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, latinhaRect.inflate(2));
    } else {
      latinhaSprite[latinhaSpriteIndex.toInt()]
          .renderRect(c, latinhaRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      latinhaRect = latinhaRect.translate(0, game.tileSize * 12 * t);
      if (latinhaRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }
    double stepDistance = speed * t;
    Offset toTarget =
        targetLocation - Offset(latinhaRect.left, latinhaRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      latinhaRect = latinhaRect.shift(stepToTarget);
    } else {
      latinhaRect = latinhaRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void onTapDown() {
    isDead = true;
    game.spawnFly();
    Flame.audio.play('tiro.wav');
  }
}
