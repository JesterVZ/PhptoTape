import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpClient{
  final Dio _apiClient = _getDio(baseUrl: null);
  final CookieJar _cookieJar = _getCookieJar();

  String api_key = 'fc1db6960ed9113413db046af761ce29';

  static Dio _getDio({String? baseUrl}) {
    return Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: 30000,
      contentType: Headers.jsonContentType,
    ));
  }
  static CookieJar _getCookieJar(){
    return CookieJar();
  }

  Future<Object?> getPhotos(int page) async{
    String uri = 'https://www.flickr.com/services/rest';
    try{
      var formData = FormData.fromMap({
        'method': 'flickr.photos.search',
        'api_key': api_key,
        'format': 'json',
        'nojsoncallback': '1',
        'tags': 'cat',
        'page': page
      });
      var cookieJar=CookieJar();
      _apiClient.interceptors.add(CookieManager(cookieJar));
      final response = await _apiClient.post(uri, data: formData);
      if(response.statusCode == 200){
        return response.data;
      }
    }catch(e){
      return e;
    }

  }
}