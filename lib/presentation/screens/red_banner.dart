import 'package:flutter/material.dart';
import 'package:transit_ride_app/config/theme/app_colors.dart'; 

class RedBanner extends StatelessWidget {
  final String bodyText;
  final bool isVisible;
  const RedBanner({super.key, required this.bodyText, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        color: kMTMRed,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          bodyText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      )
    );
  }
}


