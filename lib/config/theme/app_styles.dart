
import 'package:flutter/material.dart';
import 'package:transit_ride_app/config/theme/app_colors.dart';

class AppStyles {

  static ButtonStyle buttonBlueRounded() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(color: kMTMDarkBlue),
        ),
      ),
      backgroundColor:
      MaterialStateProperty.all<Color>(kMTMDarkBlue),
      foregroundColor:
      MaterialStateProperty.all<Color>(Colors.white),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(12.0),
      ),
    );
  }

  static ButtonStyle buttonBlueRoundedWithEnabling(bool enabled) {
    final colorEnabled = enabled ? kMTMDarkBlue : kMTMInactiveBlue;
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: colorEnabled),
        ),
      ),
      backgroundColor:
      MaterialStateProperty.all<Color>(colorEnabled),
      foregroundColor:
      MaterialStateProperty.all<Color>(Colors.white),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(12.0),
      ),
    );
  }


}