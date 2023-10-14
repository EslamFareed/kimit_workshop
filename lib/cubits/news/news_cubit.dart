import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kimit_workshop/db/dio/dio_helper.dart';
import 'package:kimit_workshop/models/news_model.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  NewsReponseModel? newsReponseModel;

  void getData() async {
    emit(LoadingNews());
    DioHelper.dio
        .get(
            "https://newsapi.org/v2/everything?q=News&apiKey=e3b8fdc5a0154931b38b9162b1ee0aac")
        .then((value) {
      if (value.statusCode == 200) {
        newsReponseModel = NewsReponseModel.fromJson(value.data);
        emit(SuccessNews());
      } else {
        emit(ErrorNews());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ErrorNews());
    });
  }
}
