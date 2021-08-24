abstract class GetPicturesError implements Exception {}

class InvalidParamettersGetPicturesError implements GetPicturesError {}

class GetPicturesRequestError implements GetPicturesError {
  final String message;
  GetPicturesRequestError({this.message});
}
