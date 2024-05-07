import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transit_ride_app/app.dart';
import 'package:transit_ride_app/data/providers/configuration_provider.dart';
import 'package:transit_ride_app/data/providers/security_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  IDPConfiguration.setIDPConfiguration(
    "idp.reveal-dev.net",
    "transit-ripta-mobile-client",
    "transitriptamobileauthdev://callback",
    [
    "api.api1",
    "id.custom",
    "profile",
    "openid"
  ]
  );
  runApp(
    Provider(
      create: (_) => SecurityProvider(),
      child: MemberApp(),
    ),
  );
}