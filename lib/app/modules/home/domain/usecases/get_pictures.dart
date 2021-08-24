import 'package:dartz/dartz.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_picture/app/modules/home/domain/repositories/home_repository.dart';

abstract class GetPictures {
  Future<Either<GetPicturesError, List<Picture>>> call(int quantityOfPictures);
}

class GetPicturesImpl implements GetPictures {
  final HomeRepository repository;

  GetPicturesImpl(this.repository);

  @override
  Future<Either<GetPicturesError, List<Picture>>> call(
      int quantityOfPictures) async {
    if (quantityOfPictures == null || quantityOfPictures == 0)
      return Left(InvalidParamettersGetPicturesError());

    return await repository.searchPicture(quantityOfPictures);
  }
}
