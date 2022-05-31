import 'package:photo_tape/http/http.dart';

class MainRepo {
  final HttpClient httpClient;

  MainRepo({required this.httpClient});

  Future<Object?> getPhoto(int page, String tag) async {
    var result = await httpClient.getPhotos(page, tag);
    return result;
  }
}
