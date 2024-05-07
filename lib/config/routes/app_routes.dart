import 'package:flutter/material.dart';
import 'package:transit_ride_app/presentation/screens/app_home.dart';
import 'package:transit_ride_app/presentation/screens/sign_in_screen.dart';

class AppRoutes {
  static const String signInRoute = '/signIn';
  static const String appHomeRoute = '/appHome';
  
  Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case signInRoute:
      return MaterialPageRoute(builder: (context) => const SignInScreen());
    case appHomeRoute:
      return MaterialPageRoute(builder: (context) => const AppHome());
    default:
      return MaterialPageRoute(builder: (context) => const SignInScreen());
  }
}
}