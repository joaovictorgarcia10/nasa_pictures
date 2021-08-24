import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/filter_by_date.dart';
import 'package:nasa_picture/app/modules/home/presenter/filter_pictures/filter_pictures_bloc.dart';
import 'package:nasa_picture/app/modules/home/presenter/filter_pictures/filter_pictures_state.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';

class FilterPicturesMock extends Mock implements FilterByDate {}

main() {
  final usecase = FilterPicturesMock();
  final bloc = FilterPicturesBloc(usecase);

  test('Deve retornar os estados na ordem [loading -> success]', () async {
    when(usecase.call(any)).thenAnswer((_) async => Right(Picture()));

    expect(
        bloc,
        emitsInOrder([
          isA<FilteredPicturesStateLoading>(),
          isA<FilteredPicturesStateSuccess>(),
        ]));

    bloc.add('2021-05-12');
  });

  test('Deve retornar os estados na ordem [loading -> error]', () async {
    when(usecase.call(any))
        .thenAnswer((_) async => Left(InvalidParamettersGetPicturesError()));

    expect(
        bloc,
        emitsInOrder([
          isA<FilteredPicturesStateLoading>(),
          isA<FilteredPicturesStateError>(),
        ]));

    bloc.add('2021-05-12');
  });
}
