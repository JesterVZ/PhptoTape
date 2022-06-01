import 'package:oauth1/oauth1.dart' as oauth1;
class FlickrApiClient{
  static const String FLICKR_API_URL_OAUTH_BASE="https://www.flickr.com/services/oauth";
  static String FLICKR_API_URL_REQUEST_TOKEN ="$FLICKR_API_URL_OAUTH_BASE/request_token";
  static String FLICKR_API_URL_AUTHORIZE="$FLICKR_API_URL_OAUTH_BASE/authorize";
  static String FLICKR_API_URL_ACCESS_TOKEN="$FLICKR_API_URL_OAUTH_BASE/access_token";

  String api_key;
  String secret_key;

  FlickrApiClient({
    required this.api_key,
    required this.secret_key
  });

  final platform = oauth1.Platform(
      FLICKR_API_URL_REQUEST_TOKEN,
      FLICKR_API_URL_AUTHORIZE,
      FLICKR_API_URL_ACCESS_TOKEN,
      oauth1.SignatureMethods.hmacSha1// signature method
  );

  Future<String> getRequestToken() async {
    final clientCredentials = oauth1.ClientCredentials(api_key, secret_key);
    var _auth =  oauth1.Authorization(clientCredentials, platform);
    oauth1.Credentials _tempCredentials;
    final response = await _auth.requestTemporaryCredentials('oob');
    _tempCredentials = response.credentials;
    return "${_auth.getResourceOwnerAuthorizationURI(_tempCredentials.token)}";
  }

}