import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameButton {
  final id;
  String title;
  Color bg;
  bool enabled;
  GameButton({
    this.id,
    this.title = '',
    this.bg = Colors.grey,
    this.enabled = true,
  });
}
