import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:tiro_latinhas/components/latinhas.dart';
import 'package:tiro_latinhas/myGame.dart';

class Pepsi extends Latinhas {
  double get speed => game.tileSize * 5;

  Pepsi(MyGame game, double x, double y) : super(game) {
    latinhaRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    latinhaSprite = List<Sprite>();
    latinhaSprite.add(Sprite('pepsi.png'));
    deadSprite = Sprite('dead.png');
  }
}
