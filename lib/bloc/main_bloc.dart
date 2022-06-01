import 'package:bloc/bloc.dart';
import 'package:photo_tape/bloc/main_event.dart';
import 'package:photo_tape/bloc/main_state.dart';
import 'package:photo_tape/model/photo_info.dart';
import 'package:photo_tape/model/photo_model.dart';

import '../repository/main_repo.dart';

class MainBloc extends Bloc<Event, MainState> {
  final MainRepo repo;

  @override
  Stream<MainState> mapEventToState(Event event) async* {
    if (event is GetPhotosEvent) {
      yield* _handleSearchPhotos(event);
    }
    if(event is GetPhotoFullInfo){
      yield* _handleGetFullInfo(event);
    }
    if(event is SetFavorite){
      yield* _handleSetFavorite(event);
    }
  }

  MainBloc(this.repo) : super(MainState.initial());

  getPhotos(int page, String tag) {
    add(GetPhotosEvent(page, tag));
  }

  getInfo(String photoId, String secret){
    add(GetPhotoFullInfo(photoId, secret));
  }

  setFavorite(String id){
    add(SetFavorite(id));
  }

  Stream<MainState> _handleSearchPhotos(GetPhotosEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object? result = await repo.getPhoto(event.page, event.tag);
      if (result is Map<String, dynamic>) {
        yield state.copyWith(
            error: null, loading: false, photos: result, action: "search");
      } else {
        yield state.copyWith(error: result, loading: false, action: "search");
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<MainState> _handleGetFullInfo(GetPhotoFullInfo event) async* {
    yield state.copyWith(loading: true, error: null);
    try{
      Object? result = await repo.getPhotoInfo(event.photoId, event.secret);
      if(result is PhotoInfo){
        yield state.copyWith(
            error: null, loading: false, photoInfo: result);
      }
    }catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<MainState> _handleSetFavorite(SetFavorite event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Map<String, dynamic>? result = repo.addToFavorite(state.photos, event.id);
        yield state.copyWith(
              error: null, loading: false, photos: result, action: "setFavorite");
    }catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }
}
