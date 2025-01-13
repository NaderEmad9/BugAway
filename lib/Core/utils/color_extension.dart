import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHex() {
    return '#${(r.toInt()).toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(g.toInt()).toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(b.toInt()).toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }
}
