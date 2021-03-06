import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:photo_tape/bloc/main_event.dart';
import 'package:photo_tape/bloc/main_state.dart';
import 'package:photo_tape/locator.dart';
import 'package:photo_tape/model/photo_info.dart';
import 'package:photo_tape/model/photo_model.dart';

import '../repository/main_repo.dart';

class MainBloc extends Bloc<Event, MainState> {
  //final MainRepo repo;

  @override
  Stream<MainState> mapEventToState(Event event) async* {
    if (event is GetPhotosEvent) {
      yield* _handleSearchPhotos(event);
    }
    if (event is GetPhotoFullInfo) {
      yield* _handleGetFullInfo(event);
    }
    if (event is SetFavorite) {
      yield* _handleSetFavorite(event);
    }
    if (event is GetAccessToken) {
      yield* _handleGetAccessToken(event);
    }
    if (event is GetRequestToken) {
      yield* _handleGetRequestToken(event);
    }
    if (event is GetFavorites) {
      yield* _handleGetFavorites(event);
    }
  }

  MainBloc() : super(MainState.initial());

  getPhotos(int page, String tag) {
    add(GetPhotosEvent(page, tag));
  }

  getInfo(String photoId, String secret) {
    add(GetPhotoFullInfo(photoId, secret));
  }

  setFavorite(String id, Map<String, dynamic>? photos, String from) {
    add(SetFavorite(id, photos, from));
  }

  getAccessToken() {
    add(const GetAccessToken());
  }

  getRequestToken(String code) {
    add(GetRequestToken(code));
  }

  getFavorites() {
    add(GetFavorites());
  }

  Stream<MainState> _handleSearchPhotos(GetPhotosEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object? result =
          await locator.get<MainRepo>().getPhoto(event.page, event.tag);
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
    try {
      Object? result = await locator
          .get<MainRepo>()
          .getPhotoInfo(event.photoId, event.secret);
      if (result is PhotoInfo) {
        yield state.copyWith(error: null, loading: false, photoInfo: result);
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<MainState> _handleSetFavorite(SetFavorite event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object? result = await locator
          .get<MainRepo>()
          .addToFavoritePost(event.photos, event.id);
      if (result is Map<String, dynamic>) {
        if (event.from == "favorites") {
          yield state.copyWith(
              error: null,
              loading: false,
              favorites: result,
              action: "setFavorite");
        } else {
          yield state.copyWith(
              error: null,
              loading: false,
              photos: result,
              action: "setFavorite");
        }
      } else {
        yield state.copyWith(
            error: result, loading: false, action: "setFavorite");
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<MainState> _handleGetAccessToken(GetAccessToken event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object? result = await locator.get<MainRepo>().getAccessToken();
      yield state.copyWith(
          loading: false, error: null, accessTokenUrl: result.toString());
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<MainState> _handleGetRequestToken(GetRequestToken event) async* {
    yield state.copyWith(loading: true, error: null, accessTokenUrl: null);
    try {
      Object? result =
          await locator.get<MainRepo>().getRequestToken(event.code);
      if (result is String) {
        yield state.copyWith(error: null, loading: false, alert: result);
      } else {
        yield state.copyWith(error: result, loading: false);
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<MainState> _handleGetFavorites(GetFavorites event) async* {
    yield state.copyWith(loading: true, error: null, accessTokenUrl: null);

    try {
      Object? result = await locator.get<MainRepo>().getFavoriteList();
      if (result is Map<String, dynamic>) {
        yield state.copyWith(
            error: null,
            loading: false,
            favorites: result,
            action: "getFavorites");
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }
}
