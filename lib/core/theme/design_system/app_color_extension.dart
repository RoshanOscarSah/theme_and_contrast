import 'package:flutter/material.dart';
import 'package:theme_and_contrast/core/theme/design_system/app_colors.dart';

@immutable
class ExtensionColors extends ThemeExtension<ExtensionColors> {
  const ExtensionColors({
    this.transparent = AppColors.TRANSPARENT,
    this.white = AppColors.WHITE,
    this.black = AppColors.BLACK,
    this.backgroundApp = AppColors.BACKGROUND_APP,
    this.tempChartGradient1 = AppColors.TEMP_CHART_GRADIENT_1,
    this.tempChartGradient2 = AppColors.TEMP_CHART_GRADIENT_2,
    this.brandYellow = AppColors.BRAND_YELLOW,
    this.brandBrown = AppColors.BRAND_BROWN,
    //yellow
    this.yellow50 = AppColors.YELLOW_50,
    this.yellow100 = AppColors.YELLOW_100,
    this.yellow200 = AppColors.YELLOW_200,
    this.yellow300 = AppColors.YELLOW_300,
    this.yellow400 = AppColors.YELLOW_400,
    this.yellow500 = AppColors.YELLOW_500,
    this.yellow600 = AppColors.YELLOW_600,
    this.yellow700 = AppColors.YELLOW_700,
    this.yellow800 = AppColors.YELLOW_800,
    this.yellow900 = AppColors.YELLOW_900,
    //grayTaupe
    this.grayTaupe50 = AppColors.GRAY_TAUPE_50,
    this.grayTaupe100 = AppColors.GRAY_TAUPE_100,
    this.grayTaupe200 = AppColors.GRAY_TAUPE_200,
    this.grayTaupe300 = AppColors.GRAY_TAUPE_300,
    this.grayTaupe400 = AppColors.GRAY_TAUPE_400,
    this.grayTaupe500 = AppColors.GRAY_TAUPE_500,
    this.grayTaupe600 = AppColors.GRAY_TAUPE_600,
    this.grayTaupe700 = AppColors.GRAY_TAUPE_700,
    this.grayTaupe800 = AppColors.GRAY_TAUPE_800,
    this.grayTaupe900 = AppColors.GRAY_TAUPE_900,
    this.blue50 = AppColors.BLUE_50,
    this.blue100 = AppColors.BLUE_100,
    this.blue200 = AppColors.BLUE_200,
    this.blue300 = AppColors.BLUE_300,
    this.blue400 = AppColors.BLUE_400,
    this.blue500 = AppColors.BLUE_500,
    this.blue600 = AppColors.BLUE_600,
    this.blue700 = AppColors.BLUE_700,
    this.blue800 = AppColors.BLUE_800,
    this.blue900 = AppColors.BLUE_900,
    this.red50 = AppColors.RED_50,
    this.red100 = AppColors.RED_100,
    this.red200 = AppColors.RED_200,
    this.red300 = AppColors.RED_300,
    this.red400 = AppColors.RED_400,
    this.red500 = AppColors.RED_500,
    this.red600 = AppColors.RED_600,
    this.red700 = AppColors.RED_700,
    this.red800 = AppColors.RED_800,
    this.red900 = AppColors.RED_900,
    this.green40 = AppColors.GREEN_40,
    this.green99 = AppColors.GREEN_99,
    this.green100 = AppColors.GREEN_100,
    this.green200 = AppColors.GREEN_200,
    this.green300 = AppColors.GREEN_300,
    this.green400 = AppColors.GREEN_400,
    this.green500 = AppColors.GREEN_500,
    this.green600 = AppColors.GREEN_600,
    this.green700 = AppColors.GREEN_700,
    this.green800 = AppColors.GREEN_800,
    this.green900 = AppColors.GREEN_900,
    this.brown50 = AppColors.BROWN_50,
    this.brown100 = AppColors.BROWN_100,
    this.brown200 = AppColors.BROWN_200,
    this.brown300 = AppColors.BROWN_300,
    this.brown400 = AppColors.BROWN_400,
    this.brown500 = AppColors.BROWN_500,
    this.brown600 = AppColors.BROWN_600,
    this.brown700 = AppColors.BROWN_700,
    this.brown800 = AppColors.BROWN_800,
    this.brown900 = AppColors.BROWN_900,
    this.gray50 = AppColors.GRAY_50,
    this.gray100 = AppColors.GRAY_100,
    this.gray200 = AppColors.GRAY_200,
    this.gray300 = AppColors.GRAY_300,
    this.gray400 = AppColors.GRAY_400,
    this.gray500 = AppColors.GRAY_500,
    this.gray600 = AppColors.GRAY_600,
    this.gray700 = AppColors.GRAY_700,
    this.gray800 = AppColors.GRAY_800,
    this.gray900 = AppColors.GRAY_900,
    this.orange50 = AppColors.ORANGE_50,
    this.orange100 = AppColors.ORANGE_100,
    this.orange200 = AppColors.ORANGE_200,
    this.orange300 = AppColors.ORANGE_300,
    this.orange400 = AppColors.ORANGE_400,
    this.orange500 = AppColors.ORANGE_500,
    this.orange600 = AppColors.ORANGE_600,
    this.orange700 = AppColors.ORANGE_700,
    this.orange800 = AppColors.ORANGE_800,
    this.orange900 = AppColors.ORANGE_900,
    this.amber50 = AppColors.AMBER_50,
    this.amber100 = AppColors.AMBER_100,
    this.amber200 = AppColors.AMBER_200,
    this.amber300 = AppColors.AMBER_300,
    this.amber400 = AppColors.AMBER_400,
    this.amber500 = AppColors.AMBER_500,
    this.amber600 = AppColors.AMBER_600,
    this.amber700 = AppColors.AMBER_700,
    this.amber800 = AppColors.AMBER_800,
    this.amber900 = AppColors.AMBER_900,
    this.emerald50 = AppColors.EMERALD_50,
    this.emerald100 = AppColors.EMERALD_100,
    this.emerald200 = AppColors.EMERALD_200,
    this.emerald300 = AppColors.EMERALD_300,
    this.emerald400 = AppColors.EMERALD_400,
    this.emerald500 = AppColors.EMERALD_500,
    this.emerald600 = AppColors.EMERALD_600,
    this.emerald700 = AppColors.EMERALD_700,
    this.emerald800 = AppColors.EMERALD_800,
    this.emerald900 = AppColors.EMERALD_900,
    this.indigo50 = AppColors.INDIGO_50,
    this.indigo100 = AppColors.INDIGO_100,
    this.indigo200 = AppColors.INDIGO_200,
    this.indigo300 = AppColors.INDIGO_300,
    this.indigo400 = AppColors.INDIGO_400,
    this.indigo500 = AppColors.INDIGO_500,
    this.indigo600 = AppColors.INDIGO_600,
    this.indigo700 = AppColors.INDIGO_700,
    this.indigo800 = AppColors.INDIGO_800,
    this.indigo900 = AppColors.INDIGO_900,
    this.violet50 = AppColors.VIOLET_50,
    this.violet100 = AppColors.VIOLET_100,
    this.violet200 = AppColors.VIOLET_200,
    this.violet300 = AppColors.VIOLET_300,
    this.violet400 = AppColors.VIOLET_400,
    this.violet500 = AppColors.VIOLET_500,
    this.violet600 = AppColors.VIOLET_600,
    this.violet700 = AppColors.VIOLET_700,
    this.violet800 = AppColors.VIOLET_800,
    this.violet900 = AppColors.VIOLET_900,
    this.ensoRed001 = AppColors.ENSO_RED_001,
    this.ensoRed002 = AppColors.ENSO_RED_002,
    this.ensoRed003 = AppColors.ENSO_RED_003,
    this.ensoBlue001 = AppColors.ENSO_BLUE_001,
    this.ensoBlue002 = AppColors.ENSO_BLUE_002,
    this.ensoBlue003 = AppColors.ENSO_BLUE_003,
    this.warningTabHighSeas = AppColors.WARNING_TAB_HIGH_SEAS,
    this.warningTabSevereWeather = AppColors.WARNING_TAB_SEVERE_WEATHER,
    this.warningTabEarthquake = AppColors.WARNING_TAB_EARTHQUAKE,
    this.warningTabVolcano = AppColors.WARNING_TAB_VOLCANO,
    this.warningTabTsunami = AppColors.WARNING_TAB_TSUNAMI,
    this.backgroundPrimary = AppColors.BACKGROUND_PRIMARY,
  });

  final Color transparent;
  final Color white;
  final Color black;
  final Color backgroundApp;
  final Color tempChartGradient1;
  final Color tempChartGradient2;
  final Color brandYellow;
  final Color brandBrown;
  final Color yellow50;
  final Color yellow100;
  final Color yellow200;
  final Color yellow300;
  final Color yellow400;
  final Color yellow500;
  final Color yellow600;
  final Color yellow700;
  final Color yellow800;
  final Color yellow900;
  final Color grayTaupe50;
  final Color grayTaupe100;
  final Color grayTaupe200;
  final Color grayTaupe300;
  final Color grayTaupe400;
  final Color grayTaupe500;
  final Color grayTaupe600;
  final Color grayTaupe700;
  final Color grayTaupe800;
  final Color grayTaupe900;
  final Color blue50;
  final Color blue100;
  final Color blue200;
  final Color blue300;
  final Color blue400;
  final Color blue500;
  final Color blue600;
  final Color blue700;
  final Color blue800;
  final Color blue900;
  final Color red50;
  final Color red100;
  final Color red200;
  final Color red300;
  final Color red400;
  final Color red500;
  final Color red600;
  final Color red700;
  final Color red800;
  final Color red900;
  final Color green40;
  final Color green99;
  final Color green100;
  final Color green200;
  final Color green300;
  final Color green400;
  final Color green500;
  final Color green600;
  final Color green700;
  final Color green800;
  final Color green900;
  final Color brown50;
  final Color brown100;
  final Color brown200;
  final Color brown300;
  final Color brown400;
  final Color brown500;
  final Color brown600;
  final Color brown700;
  final Color brown800;
  final Color brown900;
  final Color gray50;
  final Color gray100;
  final Color gray200;
  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray800;
  final Color gray900;
  final Color orange50;
  final Color orange100;
  final Color orange200;
  final Color orange300;
  final Color orange400;
  final Color orange500;
  final Color orange600;
  final Color orange700;
  final Color orange800;
  final Color orange900;
  final Color amber50;
  final Color amber100;
  final Color amber200;
  final Color amber300;
  final Color amber400;
  final Color amber500;
  final Color amber600;
  final Color amber700;
  final Color amber800;
  final Color amber900;
  final Color emerald50;
  final Color emerald100;
  final Color emerald200;
  final Color emerald300;
  final Color emerald400;
  final Color emerald500;
  final Color emerald600;
  final Color emerald700;
  final Color emerald800;
  final Color emerald900;
  final Color indigo50;
  final Color indigo100;
  final Color indigo200;
  final Color indigo300;
  final Color indigo400;
  final Color indigo500;
  final Color indigo600;
  final Color indigo700;
  final Color indigo800;
  final Color indigo900;
  final Color violet50;
  final Color violet100;
  final Color violet200;
  final Color violet300;
  final Color violet400;
  final Color violet500;
  final Color violet600;
  final Color violet700;
  final Color violet800;
  final Color violet900;
  final Color ensoRed001;
  final Color ensoRed002;
  final Color ensoRed003;
  final Color ensoBlue001;
  final Color ensoBlue002;
  final Color ensoBlue003;
  final Color warningTabHighSeas;
  final Color warningTabSevereWeather;
  final Color warningTabEarthquake;
  final Color warningTabVolcano;
  final Color warningTabTsunami;
  final Color backgroundPrimary;

  @override
  ExtensionColors copyWith() => ExtensionColors(
    transparent: transparent,
    white: white,
    black: black,
    backgroundApp: backgroundApp,
    tempChartGradient1: tempChartGradient1,
    tempChartGradient2: tempChartGradient2,
    brandYellow: brandYellow,
    brandBrown: brandBrown,
    yellow50: yellow50,
    yellow100: yellow100,
    yellow200: yellow200,
    yellow300: yellow300,
    yellow400: yellow400,
    yellow500: yellow500,
    yellow600: yellow600,
    yellow700: yellow700,
    yellow800: yellow800,
    yellow900: yellow900,
    grayTaupe50: grayTaupe50,
    grayTaupe100: grayTaupe100,
    grayTaupe200: grayTaupe200,
    grayTaupe300: grayTaupe300,
    grayTaupe400: grayTaupe400,
    grayTaupe500: grayTaupe500,
    grayTaupe600: grayTaupe600,
    grayTaupe700: grayTaupe700,
    grayTaupe800: grayTaupe800,
    grayTaupe900: grayTaupe900,
    blue50: blue50,
    blue100: blue100,
    blue200: blue200,
    blue300: blue300,
    blue400: blue400,
    blue500: blue500,
    blue600: blue600,
    blue700: blue700,
    blue800: blue800,
    blue900: blue900,
    red50: red50,
    red100: red100,
    red200: red200,
    red300: red300,
    red400: red400,
    red500: red500,
    red600: red600,
    red700: red700,
    red800: red800,
    red900: red900,
    green40: green40,
    green99: green99,
    green100: green100,
    green200: green200,
    green300: green300,
    green400: green400,
    green500: green500,
    green600: green600,
    green700: green700,
    green800: green800,
    green900: green900,
    brown50: brown50,
    brown100: brown100,
    brown200: brown200,
    brown300: brown300,
    brown400: brown400,
    brown500: brown500,
    brown600: brown600,
    brown700: brown700,
    brown800: brown800,
    brown900: brown900,
    gray50: gray50,
    gray100: gray100,
    gray200: gray200,
    gray300: gray300,
    gray400: gray400,
    gray500: gray500,
    gray600: gray600,
    gray700: gray700,
    gray800: gray800,
    gray900: gray900,
    orange50: orange50,
    orange100: orange100,
    orange200: orange200,
    orange300: orange300,
    orange400: orange400,
    orange500: orange500,
    orange600: orange600,
    orange700: orange700,
    orange800: orange800,
    orange900: orange900,
    amber50: amber50,
    amber100: amber100,
    amber200: amber200,
    amber300: amber300,
    amber400: amber400,
    amber500: amber500,
    amber600: amber600,
    amber700: amber700,
    amber800: amber800,
    amber900: amber900,
    emerald50: emerald50,
    emerald100: emerald100,
    emerald200: emerald200,
    emerald300: emerald300,
    emerald400: emerald400,
    emerald500: emerald500,
    emerald600: emerald600,
    emerald700: emerald700,
    emerald800: emerald800,
    emerald900: emerald900,
    indigo50: indigo50,
    indigo100: indigo100,
    indigo200: indigo200,
    indigo300: indigo300,
    indigo400: indigo400,
    indigo500: indigo500,
    indigo600: indigo600,
    indigo700: indigo700,
    indigo800: indigo800,
    indigo900: indigo900,
    violet50: violet50,
    violet100: violet100,
    violet200: violet200,
    violet300: violet300,
    violet400: violet400,
    violet500: violet500,
    violet600: violet600,
    violet700: violet700,
    violet800: violet800,
    violet900: violet900,
    ensoRed001: ensoRed001,
    ensoRed002: ensoRed002,
    ensoRed003: ensoRed003,
    ensoBlue001: ensoBlue001,
    ensoBlue002: ensoBlue002,
    ensoBlue003: ensoBlue003,
    warningTabHighSeas: warningTabHighSeas,
    warningTabSevereWeather: warningTabSevereWeather,
    warningTabEarthquake: warningTabEarthquake,
    warningTabVolcano: warningTabVolcano,
    warningTabTsunami: warningTabTsunami,
    backgroundPrimary: backgroundPrimary,
  );

  @override
  ExtensionColors lerp(ThemeExtension<ExtensionColors>? other, double t) =>
      this;
}

// Helper extension to safely get ExtensionColors
extension ThemeExtensionHelper on ThemeData {
  ExtensionColors get extensionColors {
    return extension<ExtensionColors>() ?? const ExtensionColors();
  }
}
