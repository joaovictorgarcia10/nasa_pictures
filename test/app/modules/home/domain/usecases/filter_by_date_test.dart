import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_picture/app/modules/home/domain/repositories/home_repository.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/filter_by_date.dart';

class HomeRepositoryMock extends Mock implements HomeRepository {}

main() {
  final repository = HomeRepositoryMock();
  final filterByDate = FilterByDateImpl(repository);

  test('deve retornar uma lista de pictures', () async {
    when(repository.filterByDate(any)).thenAnswer(
      (_) async => Right(Picture()),
    );

    var result = await filterByDate('12-05-2021');
    expect(result | null, isA<Picture>());
  });

  test('deve retornar um erro caso o parâmetro de entrada for null', () async {
    when(repository.filterByDate(any)).thenAnswer(
      (_) async => Right(Picture()),
    );

    var result = await filterByDate(null);
    expect(result.fold(id, id), isA<InvalidParamettersGetPicturesError>());

    result = await filterByDate('');
    expect(result.fold(id, id), isA<InvalidParamettersGetPicturesError>());
  });
}
