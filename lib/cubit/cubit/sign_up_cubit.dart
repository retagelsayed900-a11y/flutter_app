import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'sign_up_state.dart'; 

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> userSignUp({
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(SignUpLoadingState());

    try {
      final response = await Dio().post(
        'https://ecommerce-5rfssu72u-ahmed-allams-projects-14fb3aa3.vercel.app/register',
        data: {
          "name": name,
          "phone": phone,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignUpSuccessState(message: "Register Success Successfully!"));
      } else {
        emit(SignUpErrorState(error: "Something went wrong"));
      }
    } catch (e) {
      emit(SignUpErrorState(error: e.toString()));
    }
  }
}