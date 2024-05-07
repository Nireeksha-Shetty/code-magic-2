import 'package:flutter/material.dart';
import 'package:transit_ride_app/config/theme/app_colors.dart';

class AppThemes {
  static final ThemeData appThemeDark =
      ThemeData.dark(useMaterial3: false).copyWith(
    // Colors
    primaryColor: kMTMDarkBlue,
    shadowColor: kMTMDarkCardColor,

    appBarTheme: ThemeData.dark(useMaterial3: false).appBarTheme.copyWith(
          color: kMTMDarkBlue,
        ),

    // Icons
    primaryIconTheme:
        ThemeData.dark(useMaterial3: false).primaryIconTheme.copyWith(
              color: kMTMWhite,
            ),
    iconTheme: ThemeData.dark(useMaterial3: false).iconTheme.copyWith(
          color: kMTMDarkBlue,
        ),

    floatingActionButtonTheme:
        ThemeData.dark(useMaterial3: false).floatingActionButtonTheme.copyWith(
              backgroundColor: kMTMGreen,
            ),

    cardTheme: ThemeData.dark(useMaterial3: false).cardTheme.copyWith(
          color: kMTMDarkCardColor,
          shadowColor: kMTMDarkCardColor,
        ),

    scaffoldBackgroundColor: kMTMDarkCardColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kMTMGreen),
  );

  static final ThemeData appThemeLight =
      ThemeData.light(useMaterial3: false).copyWith(
    // Colors
    primaryColor: kMTMDarkBlue,
    primaryColorLight: kMTMLightCardColor,
    shadowColor: Colors.grey.withOpacity(0.3),
    indicatorColor: kMTMLightGreen,

    appBarTheme: ThemeData.light(useMaterial3: false).appBarTheme.copyWith(
          color: kMTMDarkBlue,
        ),

    // Buttons
    buttonTheme: ThemeData.light(useMaterial3: false).buttonTheme.copyWith(
          buttonColor: kMTMDarkBlue,
          textTheme: ButtonTextTheme.primary,
        ),

    // Icons
    primaryIconTheme:
        ThemeData.light(useMaterial3: false).primaryIconTheme.copyWith(
              color: kMTMWhite,
            ),
    iconTheme: ThemeData.dark(useMaterial3: false).iconTheme.copyWith(
          color: kMTMDarkBlue,
        ),

    floatingActionButtonTheme:
        ThemeData.light(useMaterial3: false).floatingActionButtonTheme.copyWith(
              backgroundColor: kMTMGreen,
            ),

    cardTheme: ThemeData.light(useMaterial3: false).cardTheme.copyWith(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
        ),

    scaffoldBackgroundColor: kMTMWhite,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kMTMGreen),
  );
}
