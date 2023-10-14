part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

class LoadingNews extends NewsState {}

class SuccessNews extends NewsState {}

class ErrorNews extends NewsState {}
