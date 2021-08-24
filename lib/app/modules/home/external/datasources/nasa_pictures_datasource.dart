import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nasa_picture/app/modules/home/domain/errors/errors.dart';

import 'package:nasa_picture/app/modules/home/infra/datasources/home_datasource.dart';
import 'package:nasa_picture/app/modules/home/infra/models/picture_model.dart';
import 'package:nasa_picture/app/shared/config.dart';

class NasaPicturesDatasource implements HomeDatasource {
  final Dio dio;

  NasaPicturesDatasource(this.dio);

  @override
  Future<List<PictureModel>> getPictures(int quantityOfPictures) async {
    final response = await dio.get('$BASE_URI&count=$quantityOfPictures');

    if (response.statusCode >= 200 && response.statusCode < 300)
      return (response.data as List)
          .map((e) => PictureModel.fromMap(e))
          .toList();
    else
      throw GetPicturesRequestError();
  }

  @override
  Future<PictureModel> filterByDate(String dateFilter) async {
    final response = await dio.get('$BASE_URI&date=$dateFilter');

    if (response.statusCode >= 200 && response.statusCode < 300)
      return PictureModel.fromJson(jsonEncode(response.data));
    else
      throw GetPicturesRequestError();
  }
}
