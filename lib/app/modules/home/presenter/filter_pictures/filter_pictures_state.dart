import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';

abstract class FilteredPicturesState {}

class FilteredPicturesStateSuccess implements FilteredPicturesState {
  final Picture picture;

  FilteredPicturesStateSuccess(this.picture);
}

class FilteredPicturesStateStart implements FilteredPicturesState {}

class FilteredPicturesStateLoading implements FilteredPicturesState {}

class FilteredPicturesStateError implements FilteredPicturesState {
  final GetPicturesError error;

  FilteredPicturesStateError(this.error);
}
