import 'package:photo_tape/model/photo_model.dart';

class MainState{
  final bool? loading;
  final Object? error;
  final List<PhotoModel>? photos;

  MainState({this.loading, this.error, this.photos});


  static initial() => MainState(
    loading: false,
    error: null,
  );

  MainState copyWith({
    bool? loading,
    Object? error,
    List<PhotoModel>? photos
  }){
    return MainState(
      error: error,
      loading: loading ?? this.loading,
      photos: photos ?? this.photos
    );
  }
}