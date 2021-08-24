import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_picture/app/modules/home/presenter/list_pictures/list_pictures_bloc.dart';
import 'package:nasa_picture/app/modules/home/presenter/list_pictures/list_pictures_state.dart';
import 'package:nasa_picture/app/shared/theme/app_colors.dart';
import 'package:nasa_picture/app/shared/theme/app_texts.dart';

class ListPicturesPage extends StatefulWidget {
  ListPicturesPage({Key key}) : super(key: key);
  @override
  ListPicturesPageState createState() => ListPicturesPageState();
}

class ListPicturesPageState extends State<ListPicturesPage> {
  final bloc = Modular.get<ListPicturesBloc>();

  @override
  void initState() {
    bloc.add(10);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "Nasa Pictures",
          style: AppTexts.titleBold,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range_outlined),
            onPressed: () => Modular.to.pushNamed('/filter'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is ListPicturesStateStart)
                    return Center(
                        child: Text(
                      'Estado iniciado',
                      style: AppTexts.headingBold,
                    ));

                  if (state is ListPicturesStateError)
                    return Center(
                        child: Text(
                      'Houve um erro',
                      style: AppTexts.headingBold,
                    ));

                  if (state is ListPicturesStateLoading)
                    return Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );

                  final list = (state as ListPicturesStateSuccess).pictures;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          width: 80,
                          height: 80,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "${list[index].url}",
                            placeholder: (context, url) => Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        title: Text(
                          '${list[index].title}',
                          style: AppTexts.headingBold,
                        ),
                        subtitle: Text(
                          '${list[index].date}',
                          style: AppTexts.body,
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () => bloc.add(10),
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
