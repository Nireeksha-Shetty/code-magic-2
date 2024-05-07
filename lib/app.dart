import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:transit_ride_app/config/routes/app_routes.dart';
import 'package:transit_ride_app/config/theme/app_themes.dart';
import 'package:transit_ride_app/presentation/screens/sign_in_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MemberApp extends StatelessWidget with WidgetsBindingObserver {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static BuildContext? _currentContext;

  static BuildContext? currentContext() {
    return _currentContext;
  }

  static setCurrentContext(BuildContext context) {
    _currentContext = context;
  }

  MemberApp({super.key}) {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<bool> _init() async {
    return true;
  }

  ThemeData _getTheme(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark
        ? AppThemes.appThemeDark
        : AppThemes.appThemeLight;
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("App resumed");
        break;
      case AppLifecycleState.paused:
        print("App paused");
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: OverlaySupport(
                child: MaterialApp(
                    navigatorKey: navigatorKey,
                    onGenerateRoute: AppRoutes().generateRoute,
                    theme: _getTheme(context),
                    home: const SignInScreen())),
          );
        });
  }
}
