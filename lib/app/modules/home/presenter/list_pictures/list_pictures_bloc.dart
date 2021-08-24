import 'package:bloc/bloc.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/get_pictures.dart';
import 'package:nasa_picture/app/modules/home/presenter/list_pictures/list_pictures_state.dart';

class ListPicturesBloc extends Bloc<int, ListPicturesState> {
  final GetPictures getPictures;
  ListPicturesBloc(this.getPictures) : super(ListPicturesStateStart());

  @override
  Stream<ListPicturesState> mapEventToState(int quantityOfPictures) async* {
    yield ListPicturesStateLoading();

    final result = await getPictures(quantityOfPictures);

    yield result.fold(
      (l) => ListPicturesStateError(l),
      (r) => ListPicturesStateSuccess(r),
    );
  }
}
