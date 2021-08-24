import 'package:dartz/dartz.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';

abstract class HomeRepository {
  Future<Either<GetPicturesError, List<Picture>>> searchPicture(
      int quantityOfPictures);

  Future<Either<GetPicturesError, Picture>> filterByDate(String dateFilter);
}
