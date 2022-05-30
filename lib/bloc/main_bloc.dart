import 'package:bloc/bloc.dart';
import 'package:photo_tape/bloc/main_event.dart';
import 'package:photo_tape/bloc/main_state.dart';

import '../repository/main_repo.dart';

class MainBloc extends Bloc<Event, MainState>{
  final MainRepo repo;

  @override
  Stream<MainState> mapEventToState(Event event) async* {
    if(event is GetPhotosEvent){
      yield* _handleGetPhotos(event);
    }
  }
  MainBloc(this.repo) : super(MainState.initial());

  getPhotos(int page){
    add(GetPhotosEvent(page));
  }

  Stream<MainState> _handleGetPhotos(GetPhotosEvent event)async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object? result = await repo.getPhoto(event.page);
      
    }catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }
}