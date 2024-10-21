import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Map> products = [];

  void getProducts() async {
    products.clear();
    emit(LoadingProductsState());
    try {
      var data = await FirebaseFirestore.instance.collection("products").get();
      for (var element in data.docs) {
        products.add(element.data());
      }
      emit(SuccessProductsState());
    } catch (e) {
      print(e.toString());
      emit(FailProductsState());
    }
  }
}
