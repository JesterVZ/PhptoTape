class MainState{
  final bool? loading;
  final Object? error;

  MainState({this.loading, this.error});

  static initial() => MainState(
    loading: false,
    error: null,
  );
}