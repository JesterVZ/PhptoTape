import 'package:get_it/get_it.dart';
import 'package:photo_tape/bloc/main_bloc.dart';
import 'package:photo_tape/http/http.dart';
import 'package:photo_tape/repository/main_repo.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<HttpClient>(() => HttpClient());
  locator.registerLazySingleton<MainRepo>(() => MainRepo());
  locator.registerLazySingleton<MainBloc>(() => MainBloc());
}
