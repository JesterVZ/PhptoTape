import 'package:flutter/cupertino.dart';
import 'package:photo_tape/bloc/main_bloc.dart';
import 'package:photo_tape/http/http.dart';
import 'package:photo_tape/repository/main_repo.dart';

class DependencyProvider extends InheritedWidget {
  HttpClient? _httpClient;
  MainBloc? _mainBloc;
  MainRepo? _mainRepo;
  

  DependencyProvider({Key? key, Widget? child})
      : assert(child != null),
        super(key: key, child: child!);

  MainRepo get mainRepo{
    _mainRepo ??= MainRepo(httpClient: httpClient);
    return _mainRepo!;
  }
  HttpClient get httpClient {
    _httpClient ??= HttpClient();
    return _httpClient!;
  }
  MainBloc get mainBloc{
    _mainBloc ??= MainBloc(mainRepo);
    return _mainBloc!;
  }

  static DependencyProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}