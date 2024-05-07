import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:transit_ride_app/data/providers/configuration_provider.dart';
import 'package:http/http.dart' as http;



class SecurityProvider extends ChangeNotifier {
  final String _loggerTag = 'MTMSecurityProvider';
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final _storage = const FlutterSecureStorage();

  static final SecurityProvider _singleton = SecurityProvider.internal();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  
 SecurityProvider.internal() {

    // ignore: unused_local_variable
    Logger log = Logger('SecurityProvider.internal');
  }

  factory SecurityProvider() {
    return _singleton;
  }

  final AuthorizationServiceConfiguration _serviceConfig =
      AuthorizationServiceConfiguration(
          authorizationEndpoint:
            'https://${IDPConfiguration.baseUrl()}/connect/authorize',
          tokenEndpoint:
            'https://${IDPConfiguration.baseUrl()}/connect/token'
      );

  bool _isLoggedIn = false;
  bool isLoggedIn() => _isLoggedIn;

  bool _isLoggingIn = false;
  bool isLoggingIn() => _isLoggingIn;


  String _idToken = '';
  String get idToken => _idToken;

  String _accessToken = '';
  String get accessToken => _accessToken;

  String _refreshToken = '';
  String get refreshToken => _refreshToken;

  DateTime? _accessTokenExpiration;
  DateTime? get accessTokenExpiration => _accessTokenExpiration;


  Future<bool> signInPKCE() async {
    String loggerTag = '$_loggerTag.signInPKCE';
    Logger log = Logger(loggerTag);
    bool loginSuccess = false;
    _startLogin();
    try {
      AuthorizationTokenRequest request = AuthorizationTokenRequest(
          IDPConfiguration.clientId(), IDPConfiguration.redirectURI(),
          promptValues: ['login'],
          serviceConfiguration: _serviceConfig,
          scopes: IDPConfiguration.scopes(),
          preferEphemeralSession: true,
          );

      AuthorizationTokenResponse? response =
          await _appAuth.authorizeAndExchangeCode(request);
      if (response != null) {
        await storage.delete(key: 'refreshToken');
        await _processAuthTokenResponse(response);
        _isLoggedIn = true;
        loginSuccess = true;
      }
    } on PlatformException catch (pe) {
      log.severe('Platform Exception: ${pe.toString()}');
    } catch (e) {
      log.severe('Exception: ${e.toString()}');
    }

    log.fine('Login ${loginSuccess ? 'Successful' : 'Failed'}');

    await _endLogin(loginSuccess);

    return loginSuccess;
  }
  
  _startLogin() {
    String loggerTag = '$_loggerTag._startLogin()';
    Logger log = Logger(loggerTag);
    log.fine('Starting Login');
    _isLoggingIn = true;
  }

  _endLogin(bool isLoggedIn) async {
    String loggerTag = '$_loggerTag._endLogin()';
    Logger log = Logger(loggerTag);

    log.fine('End Login | isLoggedIn: $isLoggedIn');
    _isLoggingIn = false;
    _isLoggedIn = isLoggedIn;
  }

  _processAuthTokenResponse(AuthorizationTokenResponse response) async {
    _accessToken = response.accessToken ?? '';
    _idToken = response.idToken ?? '';
    _refreshToken = response.refreshToken ?? '';
    _accessTokenExpiration = response.accessTokenExpirationDateTime;
    await storage.write(key: 'refreshToken', value: response.refreshToken);
    await _storage.write(key: 'access_token', value: response.accessToken);
    notifyListeners();
  }

  Future<bool> signOut() async {
    String loggerTag = '$_loggerTag.signOut';
    Logger log = Logger(loggerTag);
    try {
      // Clear cached values
      _idToken = '';
      _accessToken = '';
      _refreshToken = '';
      // _Access_ Token can be cleared.
      await _storage.delete(key: 'access_token');
      await http.get(
        Uri.parse(
          IDPConfiguration.endSessionURL(),
        ),
      );
      storage.deleteAll();
      _isLoggedIn = false;
      log.fine(loggerTag, 'Sign out complete.');
    } catch (e) {
      log.severe(e.toString());
      return false;
    }
    return true;
  }
}
