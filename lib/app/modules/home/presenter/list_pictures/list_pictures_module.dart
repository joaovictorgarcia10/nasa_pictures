import 'package:flutter_modular/flutter_modular.dart';

import 'list_pictures_page.dart';

class ListPicturesModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ListPicturesPage(),
      transition: TransitionType.fadeIn,
      duration: Duration(milliseconds: 900),
    ),
  ];
}
