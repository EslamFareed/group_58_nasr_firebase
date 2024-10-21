part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


class LoadingProductsState extends HomeState{}
class SuccessProductsState extends HomeState{}
class FailProductsState extends HomeState{}