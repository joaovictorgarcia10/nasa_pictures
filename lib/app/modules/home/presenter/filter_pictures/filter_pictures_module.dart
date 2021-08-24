import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_picture/app/modules/home/presenter/filter_pictures/filter_pictures_page.dart';

class FilterPicturesModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => FilterPicturesPage(),
      transition: TransitionType.fadeIn,
      duration: Duration(milliseconds: 900),
    ),
  ];
}
