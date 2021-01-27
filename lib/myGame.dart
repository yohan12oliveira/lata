import 'dart:ui';
import 'package:tiro_latinhas/view.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:tiro_latinhas/components/latinhas.dart';
import 'package:tiro_latinhas/components/pepsi.dart';
import 'package:tiro_latinhas/components/backyard.dart';

class MyGame extends Game {
  Size screenSize;
  double tileSize;
  List<Latinhas> flies;
  Random rnd;
  double x, y;

  int score;

  Backyard background;

  View activeView = View.home;

  MyGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Latinhas>();
    rnd = Random();
    score = 0;
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    spawnFly();
  }

  void spawnFly() {
    x = rnd.nextDouble() * (screenSize.width - tileSize);
    y = rnd.nextDouble() * (screenSize.height - tileSize);
    flies.add(Pepsi(this, x, y));
  }

  void render(Canvas canvas) {
    background.render(canvas);

    flies.forEach((Latinhas latinhas) => latinhas.render(canvas));
  }

  void update(double t) {
    flies.forEach((Latinhas latinhas) => latinhas.update(t));
    flies.removeWhere((Latinhas latinhas) => latinhas.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Latinhas latinhas) {
      if (latinhas.latinhaRect.contains(d.globalPosition)) {
        score++;
        print("Points: " + score.toString());
        latinhas.onTapDown();
      }
    });
  }
}
