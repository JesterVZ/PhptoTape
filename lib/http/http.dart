import 'dart:io';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:oauth1/oauth1.dart';
import 'package:photo_tape/bloc/main_event.dart';
import 'package:photo_tape/model/photo_info.dart';
import 'package:photo_tape/model/photo_model.dart';

import '../api/flicker_api_client.dart';

class HttpClient {
  final Dio _apiClient = _getDio(baseUrl: null);
  Client? client;
  final CookieJar _cookieJar = _getCookieJar();

  String api_key = '9c532bf8ed3fd9ecda75c81a6c790b82';
  String secret_key = '5d0ca9531ef61bd9';
  String mainUrl = "https://www.flickr.com/services/rest";
  FlickrApiClient? flickrApiClient;

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

  Future<Object?> getTokenUrl() async {
    flickrApiClient = FlickrApiClient(api_key: api_key, secret_key: secret_key);
    String result = await flickrApiClient!.getRequestTokenUrl();
    return result;
  }

  Future<Object?> checkToken(String token) async {}

  Future<Object?> getFavoriteList() async {
    String uri = mainUrl;
    Map<String, dynamic> formdata = {
      'api_key': api_key,
      'format': 'json',
      'nojsoncallback': '1',
      'method': 'flickr.favorites.getList'
    };
    var result = await client!.post(Uri.parse(uri), body: formdata);
    Map<String, dynamic> photosMap = {};
    final Map<String, dynamic> data = json.decode(result.body);
    for(int i = 0; i < data['photos']['photo'].length; i++){
      PhotoModel model = PhotoModel.fromMap(data['photos']['photo'][i]);
      model.isFavorite = true;
      Map<String, dynamic> map = {
            data['photos']['photo'][i]['id']: model     
      };
    photosMap.addEntries(map.entries);
    }
    return photosMap;
  }

  Future<Object?> setFavorite(String photoId, bool? isFavorite) async{
    String uri = mainUrl;
    Map<String, dynamic> formdata = {
      'api_key': api_key,
      'method': (isFavorite == false || isFavorite == null) ? 'flickr.favorites.add' : 'flickr.favorites.remove',
      'format': 'json',
      'nojsoncallback': '1',
      'photo_id': photoId
    };
    var result = await client!.post(Uri.parse(uri), body: formdata);
    if(result.statusCode == 200){
      final Map<String, dynamic> data = json.decode(result.body);
      return data["stat"];
    } else {
      return null;
    }
  }


  Future<Object?> getRequestToken(String code) async {
    var result = await flickrApiClient!.requestToken(code);
    if (result is Client) {
      client = result;
      return "Верификация прошла успешно!";
    } else {
      return Error();
    }
  }

  Future<Object?> getPhotos(int page, String tag) async {
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
      final response = await _apiClient.post(uri, data: formData);
      Map<String, dynamic> photosMap = {};
      if (response.statusCode == 200) {
        if (response.data['photos']['photo'].length == 0) {
          return "Ничего не найдено";
        }
        for (int i = 0; i < response.data['photos']['photo'].length; i++) {
          Map<String, dynamic> map = {
            response.data['photos']['photo'][i]['id']:
                PhotoModel.fromMap(response.data['photos']['photo'][i])
          };
          photosMap.addEntries(map.entries);
        }
        return photosMap;
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
