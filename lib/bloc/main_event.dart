import 'package:equatable/equatable.dart';

abstract class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class GetPhotosEvent extends Event {
  int page;
  String tag;
  GetPhotosEvent(this.page, this.tag);
}

class GetPhotoFullInfo extends Event {
  String photoId;
  String secret;
  GetPhotoFullInfo(this.photoId, this.secret);
}

class SetFavorite extends Event {
  String id;
  Map<String, dynamic>? photos;
  SetFavorite(this.id,this.photos);
}

class GetAccessToken extends Event {
  const GetAccessToken();
}

class GetRequestToken extends Event {
  String code;
  GetRequestToken(this.code);
}

class GetFavorites extends Event {
  const GetFavorites();
}
