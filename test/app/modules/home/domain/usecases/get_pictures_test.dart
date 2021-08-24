import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_picture/app/modules/home/domain/repositories/home_repository.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/get_pictures.dart';

class HomeRepositoryMock extends Mock implements HomeRepository {}

main() {
  final repository = HomeRepositoryMock();
  final getPictures = GetPicturesImpl(repository);

  test('deve retornar uma lista de pictures', () async {
    when(repository.searchPicture(any)).thenAnswer(
      (_) async => Right(<Picture>[]),
    );

    var result = await getPictures(5);
    expect(result | null, isA<List<Picture>>());
  });

  test('deve retornar um erro caso o parâmetro de entrada for null', () async {
    when(repository.searchPicture(any)).thenAnswer(
      (_) async => Right(<Picture>[]),
    );

    var result = await getPictures(null);
    expect(result.fold(id, id), isA<InvalidParamettersGetPicturesError>());

    result = await getPictures(0);
    expect(result.fold(id, id), isA<InvalidParamettersGetPicturesError>());
  });
}
