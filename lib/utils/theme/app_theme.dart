import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'app_colors.dart';

part 'app_text_theme.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
    brightness: Brightness.light,
    primaryColor: _LightAppColors.primary,
    scaffoldBackgroundColor: _LightAppColors.lightGrey,
    textTheme: _appTextTheme,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _LightAppColors.primary,
      onPrimary: _LightAppColors.white,
      secondary: _LightAppColors.secondary,
      onSecondary: _LightAppColors.white,
      error: _LightAppColors.errorRed,
      onError: _LightAppColors.white,
      background: _LightAppColors.lightGrey,
      onBackground: _LightAppColors.black,
      surface: _LightAppColors.white,
      onSurface: _LightAppColors.darkGrey,
      surfaceVariant: _LightAppColors.containerBackground,
      onSurfaceVariant: _LightAppColors.grey,
      outline: _LightAppColors.borderGrey,
      primaryContainer: _LightAppColors.blue,
    ),
  );
}
