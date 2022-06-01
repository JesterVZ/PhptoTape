import 'package:photo_tape/http/http.dart';

import '../model/photo_model.dart';

class MainRepo {
  final HttpClient httpClient;

  MainRepo({required this.httpClient});

  Future<Object?> getPhoto(int page, String tag) async {
    var result = await httpClient.getPhotos(page, tag);
    return result;
  }
  
  Future<Object?> getPhotoInfo(String photoId, String secret) async{
    var result = await httpClient.getPhotoInfo(photoId, secret);
    return result;
  }

  Map<String, dynamic> addToFavorite(Map<String, dynamic>? map, String id){ //mock
    PhotoModel newPhotoModel = map![id];
    newPhotoModel.isFavorite = true;
    map.update(id, (value) => newPhotoModel);
    return map;
  }
}
