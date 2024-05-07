
import 'package:flutter/material.dart';

class ConfigurationProvider with ChangeNotifier {}

class IDPConfiguration {
  static String _baseUrl = '';
  static String _clientId = '';
  static String _redirectURI = '';
  static String _endSessionURL = '';
  static String _discoveryURL = '';
  static List<String> _scopes = [];

  static setIDPConfiguration(
    String baseUrl,
    String clientId,
    String redirectURI,
    List<String> scopes,
  ) {
    _baseUrl = baseUrl;
    _clientId = clientId;
    _redirectURI = redirectURI;
    _scopes = scopes;

    _endSessionURL = 'https://$baseUrl/connect/endsession';
    _discoveryURL = 'https://$baseUrl/.well-known/openid-configuration';
  }

  static String baseUrl() => _baseUrl;
  static String clientId() => _clientId;
  static String redirectURI() => _redirectURI;
  static String endSessionURL() => _endSessionURL;
  static String discoveryURL() => _discoveryURL;
  static List<String> scopes() => _scopes;
}
