import 'package:bloc/bloc.dart';

import 'package:nasa_picture/app/modules/home/domain/usecases/filter_by_date.dart';
import 'package:nasa_picture/app/modules/home/presenter/filter_pictures/filter_pictures_state.dart';

class FilterPicturesBloc extends Bloc<String, FilteredPicturesState> {
  final FilterByDate filterByDate;

  FilterPicturesBloc(this.filterByDate) : super(FilteredPicturesStateStart());

  @override
  Stream<FilteredPicturesState> mapEventToState(String dateFilter) async* {
    yield FilteredPicturesStateLoading();

    final result = await filterByDate(dateFilter);

    yield result.fold(
      (l) => FilteredPicturesStateError(l),
      (r) => FilteredPicturesStateSuccess(r),
    );
  }
}
