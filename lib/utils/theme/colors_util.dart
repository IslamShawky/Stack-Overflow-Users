import 'package:flutter/material.dart';

Color getDifficultyLevelColor(int difficulty, BuildContext context){
  var colorScheme = Theme.of(context).colorScheme;
  return switch (difficulty) {
    1 => colorScheme.tertiaryFixed,
    2 => colorScheme.secondaryContainer,
    3 => colorScheme.secondary,
    4 => colorScheme.scrim,
    _ => colorScheme.primary,
  };
}