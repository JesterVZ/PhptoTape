import 'package:photo_tape/model/photo_info.dart';
import 'package:photo_tape/model/photo_model.dart';

class MainState {
  final bool? loading;
  final bool? isSearch;
  final Object? error;
  final Map<String, dynamic>? photos;
  final PhotoInfo? photoInfo;

  MainState({this.loading, this.error, this.photos, this.isSearch, this.photoInfo});

  static initial() => MainState(
        loading: false,
        error: null,
      );

  MainState copyWith(
      {bool? loading,
      Object? error,
      Map<String, dynamic>? photos,
      bool? isSearch,
      PhotoInfo? photoInfo}) {
    return MainState(
        error: error,
        loading: loading ?? this.loading,
        photos: photos ?? this.photos,
        photoInfo: photoInfo,
        isSearch: isSearch);
  }
}
