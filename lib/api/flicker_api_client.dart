import 'package:oauth1/oauth1.dart' as oauth1;

class FlickrApiClient {
  static const String FLICKR_API_URL_OAUTH_BASE =
      "https://www.flickr.com/services/oauth";
  static String FLICKR_API_URL_REQUEST_TOKEN =
      "$FLICKR_API_URL_OAUTH_BASE/request_token";
  static String FLICKR_API_URL_AUTHORIZE =
      "$FLICKR_API_URL_OAUTH_BASE/authorize";
  static String FLICKR_API_URL_ACCESS_TOKEN =
      "$FLICKR_API_URL_OAUTH_BASE/access_token";

  String api_key;
  String secret_key;

  var _auth;
  var clientCredentials;
  oauth1.Credentials? _tempCredentials;

  FlickrApiClient({required this.api_key, required this.secret_key});

  final platform = oauth1.Platform(
      FLICKR_API_URL_REQUEST_TOKEN,
      FLICKR_API_URL_AUTHORIZE,
      FLICKR_API_URL_ACCESS_TOKEN,
      oauth1.SignatureMethods.hmacSha1);

  Future<String> getRequestTokenUrl() async {
    clientCredentials = oauth1.ClientCredentials(api_key, secret_key);
    _auth = oauth1.Authorization(clientCredentials, platform);

    final response = await _auth.requestTemporaryCredentials('oob');
    _tempCredentials = response.credentials;
    return "${_auth.getResourceOwnerAuthorizationURI(_tempCredentials!.token)}";
  }

  Future<oauth1.Client?> requestToken(String verifier) async {
    //получаем подписанного клиента
    try {
      final response =
          await _auth.requestTokenCredentials(_tempCredentials, verifier);
      _tempCredentials = null;
      //_saveToken(response.credentials);
      var authClient = oauth1.Client(
          platform.signatureMethod, clientCredentials, response.credentials);
      return authClient;
    } catch (e) {
      return null;
    }
  }
}
