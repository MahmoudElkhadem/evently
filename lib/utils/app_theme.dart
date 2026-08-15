import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    disabledColor: AppColor.inputsLightMode,
    primaryColor: AppColor.mainLightMode,
    hintColor: AppColor.inputsLightMode,
    unselectedWidgetColor: AppColor.strokeLightMode,
    scaffoldBackgroundColor: AppColor.backgroundLightMode,
    cardColor: AppColor.disableColor,
    hoverColor: AppColor.strokeLightMode,
    splashColor: AppColor.textMainLightMode,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.mainLightMode,
      unselectedItemColor: AppColor.disableColor,
      backgroundColor: AppColor.backgroundLightMode,
      selectedLabelStyle: AppStyle.regular12LightColor,
    ),
    dividerColor: AppColor.strokeLightMode,
    textTheme: TextTheme(
      headlineLarge: AppStyle.semi20black,
      headlineMedium: AppStyle.medium18black,
      bodyLarge: AppStyle.regular16GreyColor,
      headlineSmall: AppStyle.semi24LightColor,
      labelMedium: AppStyle.medium18mainColor,
      labelSmall: AppStyle.semi16LightColor,
      bodySmall: AppStyle.medium14black,
      titleLarge: AppStyle.semi20black,
      titleMedium: AppStyle.medium18black,
      titleSmall: AppStyle.medium16SecTextBlack,
      displayMedium: AppStyle.semi20LightColor,
      labelLarge: AppStyle.semi14BoldLight,
      bodyMedium: AppStyle.main16DarkColor
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    disabledColor: AppColor.inputsDarkMode,
    primaryColor: AppColor.mainDarkMode,
    hintColor: AppColor.inputsLightMode,
    unselectedWidgetColor: AppColor.disableColor,
    scaffoldBackgroundColor: AppColor.backgroundDarkMode,
    hoverColor: AppColor.strokeDarkMode,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.backgroundDarkMode,
      selectedItemColor: AppColor.mainDarkMode,
      unselectedItemColor: AppColor.textSceLightMode,
      selectedLabelStyle: AppStyle.regular12MainDarkColor,
      unselectedLabelStyle: AppStyle.regular12GreyColor,
    ),
    splashColor: AppColor.textMainDarkMode,
    cardColor: AppColor.backgroundLightMode,
    dividerColor: AppColor.mainLightMode,
    textTheme: TextTheme(
      headlineLarge: AppStyle.semi20white,
      headlineMedium: AppStyle.medium18white,
      bodyLarge: AppStyle.regular16whiteDarkColor,
      headlineSmall: AppStyle.semi24whiteColor,
      labelMedium: AppStyle.medium18white,
      labelSmall: AppStyle.regular14whiteColor,
      bodySmall: AppStyle.regular14whiteColor,
      titleLarge: AppStyle.semi24whiteColor,
      titleMedium: AppStyle.medium18white,
      titleSmall: AppStyle.medium16SecTextLight,
      displayMedium: AppStyle.semi20DarkColor,
      labelLarge: AppStyle.semi14BoldDark,
      bodyMedium: AppStyle.main16DarkColor
    ),
  );
}