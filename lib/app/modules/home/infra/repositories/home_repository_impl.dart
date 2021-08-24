import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_picture/app/modules/home/domain/repositories/home_repository.dart';
import 'package:nasa_picture/app/modules/home/infra/datasources/home_datasource.dart';
import 'package:nasa_picture/app/modules/home/infra/models/picture_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<Either<GetPicturesError, List<PictureModel>>> searchPicture(
      int quantityOfPictures) async {
    try {
      final result = await datasource.getPictures(quantityOfPictures);
      return Right(result);
    } catch (e) {
      return Left(GetPicturesRequestError());
    }
  }

  @override
  Future<Either<GetPicturesError, Picture>> filterByDate(
      String dateFilter) async {
    try {
      final result = await datasource.filterByDate(dateFilter);
      return Right(result);
    } catch (e) {
      return Left(GetPicturesRequestError());
    }
  }
}
