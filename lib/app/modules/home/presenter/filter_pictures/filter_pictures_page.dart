import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_picture/app/modules/home/domain/usecases/filter_by_date.dart';
import 'package:nasa_picture/app/modules/home/presenter/filter_pictures/filter_pictures_state.dart';
import 'package:nasa_picture/app/shared/theme/app_colors.dart';
import 'package:nasa_picture/app/shared/theme/app_texts.dart';
import 'filter_pictures_bloc.dart';

class FilterPicturesPage extends StatefulWidget {
  @override
  _FilterPicturesPageState createState() => _FilterPicturesPageState();
}

class _FilterPicturesPageState extends State<FilterPicturesPage> {
  FilterPicturesBloc bloc;

  @override
  void initState() {
    bloc = FilterPicturesBloc(Modular.get<FilterByDate>());
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
        title: Text(
          'Filter By Date',
          style: AppTexts.titleBold,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is FilteredPicturesStateStart)
                    return Center(
                      child: Text(
                        'Escolha uma Data',
                        style: AppTexts.headingBold,
                      ),
                    );

                  if (state is FilteredPicturesStateError)
                    return Center(
                      child: Text(
                        'Houve um erro, tente novamente mais tarde',
                        style: AppTexts.headingBold,
                      ),
                    );

                  if (state is FilteredPicturesStateLoading)
                    return Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );

                  final picture =
                      (state as FilteredPicturesStateSuccess).picture;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "${picture.url}",
                            placeholder: (context, url) => Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                picture.date,
                                style: AppTexts.headingBold,
                              ),
                              SizedBox(height: 20),
                              Text(
                                picture.explanation,
                                style: AppTexts.description,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accent,
        onPressed: () {
          selectDate();
        },
        label: Text('Escolher Data'),
        icon: Icon(Icons.date_range_outlined),
      ),
    );
  }

  // Date Picker Widget
  Future<void> selectDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then(
      (date) {
        if (date == null) date = DateTime.now();
        return bloc.add(date.toString().split(' ')[0]);
      },
    );
  }
}

//    bloc.add('2020-10-03');
