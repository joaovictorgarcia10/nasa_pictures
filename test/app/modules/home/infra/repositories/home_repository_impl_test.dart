import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_picture/app/modules/home/infra/datasources/home_datasource.dart';
import 'package:nasa_picture/app/modules/home/infra/models/picture_model.dart';
import 'package:nasa_picture/app/modules/home/infra/repositories/home_repository_impl.dart';

class HomeDatasourceMock extends Mock implements HomeDatasource {}

main() {
  final datasource = HomeDatasourceMock();
  final repository = HomeRepositoryImpl(datasource);

  group('Get Pictures', () {
    test('deve retornar uma lista de PicturesModel', () async {
      when(datasource.getPictures(any))
          .thenAnswer((_) async => <PictureModel>[]);

      final result = await repository.searchPicture(5);
      expect(result | null, isA<List<Picture>>());
    });

    test('deve retornar um GetPicturesRequestError se o datasource falhar',
        () async {
      when(datasource.getPictures(any)).thenThrow(Exception());

      final result = await repository.searchPicture(5);
      expect(result.fold(id, id), isA<GetPicturesRequestError>());
    });
  });

  group('Filter By Date', () {
    test('deve retornar uma lista de PicturesModel filtrado pela data',
        () async {
      when(datasource.filterByDate(any))
          .thenAnswer((_) async => PictureModel());

      final result = await repository.filterByDate('12-05-2021');
      expect(result | null, isA<Picture>());
    });

    test('deve retornar um GetPicturesRequestError se o datasource falhar',
        () async {
      when(datasource.filterByDate(any)).thenThrow(Exception());

      final result = await repository.filterByDate('12-05-2021');
      expect(result.fold(id, id), isA<GetPicturesRequestError>());
    });
  });

  // Filter By Date
}
