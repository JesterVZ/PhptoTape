import 'package:photo_tape/http/http.dart';

import '../model/photo_model.dart';

class MainRepo {
  final HttpClient httpClient;

  MainRepo({required this.httpClient});

  Future<Object?> getPhoto(int page, String tag) async {
    var result = await httpClient.getPhotos(page, tag);
    return result;
  }

  Future<Object?> getPhotoInfo(String photoId, String secret) async {
    var result = await httpClient.getPhotoInfo(photoId, secret);
    return result;
  }

  Future<Object?> getAccessToken() async {
    var result = await httpClient.getTokenUrl();
    return result;
  }

  Future<Object?> getRequestToken(String code) async {
    var result = await httpClient.getRequestToken(code);
    return result;
  }

  Future<Object?> getFavoriteList() async {
    var result = await httpClient.getFavoriteList();
    return result;
  }

  Map<String, dynamic> addToFavorite(Map<String, dynamic>? map, String id) {
    //mock
    PhotoModel newPhotoModel = map![id];
    if (newPhotoModel.isFavorite == null || newPhotoModel.isFavorite == false) {
      newPhotoModel.isFavorite = true;
    } else {
      newPhotoModel.isFavorite = false;
    }
    map.update(id, (value) => newPhotoModel);
    return map;
  }

  Future<Object?> addToFavoritePost(Map<String, dynamic>? map, String id) async{
    PhotoModel newPhotoModel = map![id];
    var result = await httpClient.setFavorite(id, newPhotoModel.isFavorite);
    if(result == "ok"){
      if (newPhotoModel.isFavorite == null || newPhotoModel.isFavorite == false) {
        newPhotoModel.isFavorite = true;
      } else {
        newPhotoModel.isFavorite = false;
      }
      map.update(id, (value) => newPhotoModel);
      return map;
    } else {
      return result;
    }
  }
}
