
class Config {
  Config._();

  /// SelfSignedCert:
  static const selfSignedCert = false;

  /// API Config
  static const Duration timeout = Duration(seconds: 10);
  static const logNetworkRequest = true;
  static const logNetworkRequestHeader = true;
  static const logNetworkRequestBody = true;
  static const logNetworkResponseHeader = false;
  static const logNetworkResponseBody = true;
  static const logNetworkError = true;
}

enum APILog { cURL, request }
