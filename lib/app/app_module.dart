import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/filter_by_date.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/get_pictures.dart';
import 'package:nasa_picture/app/modules/home/external/datasources/nasa_pictures_datasource.dart';
import 'package:nasa_picture/app/modules/home/infra/repositories/home_repository_impl.dart';
import 'package:nasa_picture/app/modules/home/presenter/filter_pictures/filter_pictures_bloc.dart';
import 'package:nasa_picture/app/modules/home/presenter/list_pictures/list_pictures_bloc.dart';
import 'package:nasa_picture/app/modules/home/presenter/list_pictures/list_pictures_module.dart';

import 'modules/home/presenter/filter_pictures/filter_pictures_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => NasaPicturesDatasource(i())),
        Bind((i) => HomeRepositoryImpl(i())),
        Bind((i) => GetPicturesImpl(i())),
        Bind((i) => ListPicturesBloc(i())),
        Bind((i) => FilterByDateImpl(i())),
        Bind((i) => FilterPicturesBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: ListPicturesModule()),
        ModuleRoute('/filter', module: FilterPicturesModule()),
      ];
}
