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

  Map<String, PhotoModel> addToFavorite(PhotoModel photoModel){
    Map<String, PhotoModel> map = {
      '${photoModel.id}':photoModel
    };
    return map;
  }
}
