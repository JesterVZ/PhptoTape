import 'package:equatable/equatable.dart';

abstract class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class GetPhotosEvent extends Event {
  int page;
  String tag;
  GetPhotosEvent(this.page, this.tag);
}
