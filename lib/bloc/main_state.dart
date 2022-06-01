import 'package:photo_tape/model/photo_info.dart';
import 'package:photo_tape/model/photo_model.dart';

class MainState {
  final bool? loading;
  final String? action;
  final String? accessTokenUrl;
  final String? alert;
  final Object? error;
  final Map<String, dynamic>? photos;
  final PhotoInfo? photoInfo;

  MainState(
      {this.loading,
      this.error,
      this.photos,
      this.action,
      this.photoInfo,
      this.accessTokenUrl,
      this.alert});

  static initial() => MainState(
        loading: false,
        error: null,
      );

  MainState copyWith(
      {bool? loading,
      Object? error,
      Map<String, dynamic>? photos,
      String? action,
      String? alert,
      String? accessTokenUrl,
      PhotoInfo? photoInfo}) {
    return MainState(
        error: error,
        loading: loading ?? this.loading,
        photos: photos ?? this.photos,
        photoInfo: photoInfo,
        accessTokenUrl: accessTokenUrl,
        action: action,
        alert: alert);
  }
}
