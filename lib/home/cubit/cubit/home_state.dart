part of 'home_cubit.dart';


sealed class HomeState {}

final class HomeInitial extends HomeState {}

// Banners States
final class HomeBannersLoadingState extends HomeState {}

final class HomeBannersSuccessState extends HomeState {
  final BannerModel bannerModel;
  HomeBannersSuccessState({required this.bannerModel});
}

final class HomeBannersErrorState extends HomeState {}

// Products States
final class HomeProductsLoadingState extends HomeState {}

final class HomeProductsSuccessState extends HomeState {
  final ProductModel productModel;
  HomeProductsSuccessState({required this.productModel});
}

final class HomeProductsErrorState extends HomeState {}