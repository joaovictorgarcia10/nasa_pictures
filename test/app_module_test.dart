import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture/app/app_module.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/filter_by_date.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/get_pictures.dart';
import 'app/modules/home/utils/get_one_picture_response.dart';
import 'app/modules/home/utils/get_pictures_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  Modular.init(AppModule());
  Modular.bind(Bind<Dio>((i) => dio));

  group('Get Pictures', () {
    test('Deve recuperar o getPictures sem erro', () {
      final usecase = Modular.get<GetPictures>();
      expect(usecase, isA<GetPicturesImpl>());
    });

    test('Deve recuperar uma lista de pictures sem erro', () async {
      when(dio.get(any)).thenAnswer(
        (_) async => Response(
          data: jsonDecode(getPicturesResult),
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final usecase = Modular.get<GetPictures>();
      final result = await usecase(5);

      expect(result | null, isA<List<Picture>>());
    });
  });

  group('Get Filtered Pictures', () {
    test('Deve recuperar o getPictures sem erro', () {
      final usecase = Modular.get<FilterByDate>();
      expect(usecase, isA<FilterByDateImpl>());
    });

    test('Deve recuperar uma lista de pictures filtradas sem erro', () async {
      when(dio.get(any)).thenAnswer(
        (_) async => Response(
          data: jsonDecode(getOnePictureResult),
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final usecase = Modular.get<FilterByDate>();
      final result = await usecase('2020-05-12');

      expect(result | null, isA<Picture>());
    });
  });
}
