import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/repository/news_repository.dart';

import '../models/news.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _newsRepository;
  NewsCubit(this._newsRepository) : super(NewsInitial());

  Future<void> GetNews() async {
    try {
      emit(const NewsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final response = await _newsRepository.GetNews();
      emit(NewsLoaded(response));
    } on NetworkError catch (e) {
      emit(NewsError(e.message));
    }
  }
}
