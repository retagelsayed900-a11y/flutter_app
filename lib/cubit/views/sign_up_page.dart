
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/cubit/sign_up_cubit.dart';
import 'package:project/cubit/cubit/sign_up_state.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const SignUpBodyView(),
    );
  }
}

class SignUpBodyView extends StatefulWidget {
  const SignUpBodyView({super.key});

  @override
  State<SignUpBodyView> createState() => _SignUpBodyViewState();
}

class _SignUpBodyViewState extends State<SignUpBodyView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  final Color primaryColor = const Color(0xFF40AA58);
  final Color darkColor = const Color(0xFF17172F);
  final Color greyColor = const Color(0xFF999999);

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is SignUpErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  Text(
                    'Welcome to our\ngrocery shop',
                    style: TextStyle(
                      color: darkColor,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 45),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(28, 50, 28, 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        buildLabel('Name'),
                        const SizedBox(height: 12),
                        buildTextField(
                          controller: nameController,
                          hint: 'Enter your name',
                        ),
                        const SizedBox(height: 42),

                        buildLabel('Phone Number'),
                        const SizedBox(height: 12),
                        buildTextField(
                          controller: phoneController,
                          hint: 'Enter your phone number',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 42),

                        buildLabel('Password'),
                        const SizedBox(height: 12),
                        TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 95),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              width: 105,
                              height: 90,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: state is SignUpLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        BlocProvider.of<SignUpCubit>(context)
                                            .userSignUp(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          password: passwordController.text,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildLabel(String text) =>
      Text(text, style: TextStyle(color: greyColor, fontSize: 16));

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hint),
    );
  }
}