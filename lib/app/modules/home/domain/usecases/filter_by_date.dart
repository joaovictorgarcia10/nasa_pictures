import 'package:dartz/dartz.dart';

import '../entities/picture.dart';
import '../errors/errors.dart';
import '../repositories/home_repository.dart';

abstract class FilterByDate {
  Future<Either<GetPicturesError, Picture>> call(String dateFilter);
}

class FilterByDateImpl implements FilterByDate {
  final HomeRepository repository;

  FilterByDateImpl(this.repository);

  @override
  Future<Either<GetPicturesError, Picture>> call(String dateFilter) async {
    if (dateFilter == null || dateFilter.isEmpty)
      return Left(InvalidParamettersGetPicturesError());

    return await repository.filterByDate(dateFilter);
  }
}
