part of 'news_cubit.dart';

@immutable
abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  const NewsInitial();
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  const NewsLoading();
  @override
  List<Object?> get props => [];
}

class NewsLoaded extends NewsState {
  final  NewsModel response;
  const NewsLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class NewsError extends NewsState {
  final String message;
  const NewsError(this.message );
  @override
  List<Object?> get props => [];
}
