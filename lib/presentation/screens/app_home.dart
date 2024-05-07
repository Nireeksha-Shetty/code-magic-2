import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transit_ride_app/config/routes/app_routes.dart';
import 'package:transit_ride_app/data/providers/security_provider.dart';
import 'package:transit_ride_app/config/theme/app_colors.dart';
import 'package:transit_ride_app/presentation/screens/overlay_loader.dart';
import 'package:transit_ride_app/utils/constants/app_constants.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}


class _AppHomeState extends State<AppHome> {
  bool isLoggedIn = false;
  bool loaderStatus = false;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    print("Access Token : ${SecurityProvider().accessToken}");
    print("Id Token : ${SecurityProvider().idToken}");
    print("Refresh Token : ${SecurityProvider().refreshToken}");
    print("Token Expiration : ${SecurityProvider().accessTokenExpiration}");
    return OverlayLoader(
      isLoading: loaderStatus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMTMDarkBlue,
          title: Semantics(label: "MTM Logo", child: Image.asset(AppConstants.appBarLogo)),
          centerTitle: true,
          actions: [
            Semantics(
              label: "Sign Out",
              child: IconButton(
                icon: const Icon(Icons.logout_sharp),
                color: kMTMWhite,
                onPressed: () async {
                setState(() {
                  loaderStatus = true;
                });
                if(await SecurityProvider().signOut())
                {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signInRoute , (route) => false);
                }
                setState(() {
                  loaderStatus = false;
                });
                },
              ),
            ),
          ],
        ),
        body: const SafeArea(
          child: Center(child: Text("Home Page"),))),
    );
  }
}