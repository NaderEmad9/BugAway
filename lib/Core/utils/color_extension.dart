import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${red.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }
}
