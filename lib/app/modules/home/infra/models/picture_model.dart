import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:nasa_picture/app/modules/home/domain/entities/picture.dart';

extension on String {
  toBRFormat() {
    var inputDate = DateFormat('yyyy-MM-dd').parse(this);
    return DateFormat('dd/MM/yyyy').format(inputDate);
  }
}

class PictureModel extends Picture {
  final String title;
  final String date;
  final String explanation;
  final String url;

  PictureModel({
    this.title,
    this.date,
    this.explanation,
    this.url,
  }) : super(
          title: title,
          date: date,
          explanation: explanation,
          url: url,
        );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'explanation': explanation,
      'url': url,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PictureModel(
      title: map['title'],
      date: '${map['date']}'.toBRFormat(),
      explanation: map['explanation'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) =>
      PictureModel.fromMap(json.decode(source));
}
