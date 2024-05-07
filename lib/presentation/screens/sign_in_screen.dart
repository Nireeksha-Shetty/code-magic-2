import 'package:flutter/material.dart';
import 'package:transit_ride_app/app.dart';
import 'package:transit_ride_app/config/routes/app_routes.dart';
import 'package:transit_ride_app/config/theme/app_colors.dart';
import 'package:transit_ride_app/config/theme/app_styles.dart';
import 'package:transit_ride_app/data/providers/security_provider.dart';
import 'package:transit_ride_app/presentation/screens/red_banner.dart';
import 'package:transit_ride_app/utils/constants/app_constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _showSignInError = false;

  @override
  void initState() {
    super.initState();
    MemberApp.setCurrentContext(context);
  }

  _trySignIn() {
    setState(() {
      _showSignInError = false;
    });
    _launchMTMLinkLogin();
  }

  _launchMTMLinkLogin() async {
    SecurityProvider securityProvider = SecurityProvider();
    bool loggedIn = await securityProvider.signInPKCE();
    if (loggedIn) {
      await _postUserSignIn();
    } else {
      setState(() {
        _showSignInError = true;
      });
    }
  }

  _postUserSignIn() async {
    Navigator.of(
      navigatorKey.currentContext!,
      rootNavigator: true,
    ).pushNamedAndRemoveUntil(AppRoutes.appHomeRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMTMDarkBlue,
        title: Image.asset(AppConstants.appBarLogo),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: kMTMWhite,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RedBanner(
                    bodyText: AppConstants.loginError,
                    isVisible: _showSignInError),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Semantics(
                      label: "MTM Logo",
                      child: Image.asset(AppConstants.siginPageLogo)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SecurityProvider().isLoggingIn()
                      ? const Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("Please Wait")
                          ],
                        )
                      : Container(
                          height: 55.0,
                          width: 150.0,
                          child: TextButton(
                            key: const Key('sign_in'),
                            style: AppStyles.buttonBlueRounded(),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: kMTMWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                            onPressed: () async {
                              _trySignIn();
                            },
                            onLongPress: () {
                              // print("Long Pressed SignIn Button");
                            },
                          ),
                        ),
                ),
                const Text('0.00 | Build 0.0'),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
