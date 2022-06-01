import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:photo_tape/model/photo_info.dart';
import 'package:photo_tape/model/photo_model.dart';
import 'package:oauth_dio/oauth_dio.dart';

class HttpClient {
  final Dio _apiClient = _getDio(baseUrl: null);
  final CookieJar _cookieJar = _getCookieJar();

  String api_key = '9c532bf8ed3fd9ecda75c81a6c790b82';
  String secret_key = '5d0ca9531ef61bd9';
  String mainUrl = "https://www.flickr.com/services/rest";

  static Dio _getDio({String? baseUrl}) {
    return Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: 30000,
      contentType: Headers.jsonContentType,
    ));
  }

  static CookieJar _getCookieJar() {
    return CookieJar();
  }

  Future<OAuthToken?> oAuth() async {
    OAuthToken? token;
    try {
      final oauth = OAuth(
          tokenUrl: 'https://www.flickr.com/services/oauth/request_token',
          clientId: api_key,
          clientSecret: secret_key);

      token = await oauth.requestToken(PasswordGrant(
          username: 'netqualityteam@gmail.com', password: '&rNzbq=V4G.z/_5'));
      return token;
    } catch (e) {
      print(e);
    }
    return token;
  }

  Future<Object?> getPhotos(int page, String tag) async {
    //OAuthToken? token = await oAuth();
    String uri = mainUrl;
    try {
      var formData = FormData.fromMap({
        'method': 'flickr.photos.search',
        'api_key': api_key,
        'format': 'json',
        'nojsoncallback': '1',
        'tags': tag,
        'page': page
      });
      //var cookieJar = CookieJar();
      //_apiClient.interceptors.add(CookieManager(cookieJar));
      final response = await _apiClient.post(uri, data: formData);
      List<PhotoModel> photos = [];
      if (response.statusCode == 200) {
        if (response.data['photos']['photo'].length == 0) {
          return "Ничего не найдено";
        }
        for (int i = 0; i < response.data['photos']['photo'].length; i++) {
          photos.add(PhotoModel.fromMap(response.data['photos']['photo'][i]));
        }
        return photos;
      }
    } catch (e) {
      return e;
    }
    return null;
  }

  Future<Object?> getPhotoInfo(String photoId, String secret) async {
    String uri = mainUrl;
    try {
      var formData = FormData.fromMap({
        'method': 'flickr.photos.getInfo',
        'api_key': api_key,
        'format': 'json',
        'nojsoncallback': '1',
        'photo_id': photoId,
        'secret': secret
      });
      final response = await _apiClient.post(uri, data: formData);
      if (response.statusCode == 200) {
        return PhotoInfo.fromMap(response.data['photo']);
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }
}
