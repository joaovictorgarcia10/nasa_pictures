import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_picture/app/modules/home/external/datasources/nasa_pictures_datasource.dart';

import '../../utils/get_one_picture_response.dart';
import '../../utils/get_pictures_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = NasaPicturesDatasource(dio);

  group('Get Pictures', () {
    test('deve retornar uma lista de PictureModel', () async {
      when(dio.get(any)).thenAnswer((_) async => Response(
          data: jsonDecode(getPicturesResult),
          statusCode: 200,
          requestOptions: RequestOptions(path: '')));

      final future = datasource.getPictures(5);
      expect(future, completes);
    });

    test(
        'deve retornar um GetPicturesRequestError se o código for != [200, 299]',
        () async {
      when(dio.get(any)).thenAnswer((_) async => Response(
          data: null,
          statusCode: 401,
          requestOptions: RequestOptions(path: '')));

      final future = datasource.getPictures(5);
      expect(future, throwsA(isA<GetPicturesRequestError>()));
    });
  });

  group('Get Pictures Filtered', () {
    test('deve retornar uma lista de PictureModel', () async {
      when(dio.get(any)).thenAnswer((_) async => Response(
          data: jsonDecode(getOnePictureResult),
          statusCode: 200,
          requestOptions: RequestOptions(path: '')));

      final future = datasource.filterByDate('2020-05-12');
      expect(future, completes);
    });

    test(
        'deve retornar um GetPicturesRequestError se o código for != [200, 299]',
        () async {
      when(dio.get(any)).thenAnswer((_) async => Response(
          data: null,
          statusCode: 401,
          requestOptions: RequestOptions(path: '')));

      final future = datasource.filterByDate('2020-05-12');
      expect(future, throwsA(isA<GetPicturesRequestError>()));
    });
  });

  test('deve retornar um Exception caso haja erro na plataforma Dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    var future = datasource.getPictures(5);
    expect(future, throwsA(isA<Exception>()));

    var futureByDate = datasource.filterByDate('2020-05-12');
    expect(futureByDate, throwsA(isA<Exception>()));
  });
}
