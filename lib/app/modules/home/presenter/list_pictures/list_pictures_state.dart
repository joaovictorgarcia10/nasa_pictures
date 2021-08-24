import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';

abstract class ListPicturesState {}

class ListPicturesStateSuccess implements ListPicturesState {
  final List<Picture> pictures;

  ListPicturesStateSuccess(this.pictures);
}

class ListPicturesStateStart implements ListPicturesState {}

class ListPicturesStateLoading implements ListPicturesState {}

class ListPicturesStateError implements ListPicturesState {
  final GetPicturesError error;

  ListPicturesStateError(this.error);
}
