import 'package:bloc/bloc.dart';
import 'package:photo_tape/bloc/main_event.dart';
import 'package:photo_tape/bloc/main_state.dart';

import '../repository/main_repo.dart';

class MainBloc extends Bloc<Event, MainState>{
  final MainRepo repo;

  @override
  Stream<MainState> mapEventToState(Event event) async* {

  }
  MainBloc(this.repo) : super(MainState.initial());
}