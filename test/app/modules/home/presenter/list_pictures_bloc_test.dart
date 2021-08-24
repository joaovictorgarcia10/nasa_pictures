import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/get_pictures.dart';
import 'package:nasa_picture/app/modules/home/presenter/list_pictures/list_pictures_bloc.dart';
import 'package:nasa_picture/app/modules/home/presenter/list_pictures/list_pictures_state.dart';

class GetPicturesMock extends Mock implements GetPictures {}

main() {
  final usecase = GetPicturesMock();
  final bloc = ListPicturesBloc(usecase);

  test('Deve retornar os estados na ordem [loading > success]', () async {
    when(usecase.call(any)).thenAnswer((_) async => Right(<Picture>[]));

    expect(
        bloc,
        emitsInOrder([
          isA<ListPicturesStateLoading>(),
          isA<ListPicturesStateSuccess>(),
        ]));

    bloc.add(5);
  });

  test('Deve retornar os estados na ordem [loading > error]', () async {
    when(usecase.call(any))
        .thenAnswer((_) async => Left(InvalidParamettersGetPicturesError()));

    expect(
        bloc,
        emitsInOrder([
          isA<ListPicturesStateLoading>(),
          isA<ListPicturesStateError>(),
        ]));

    bloc.add(5);
  });
}
