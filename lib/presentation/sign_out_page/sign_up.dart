import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../home_page/home_page.dart';
import 'widgets/sign_up_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Переход на главную, если пользователь прошел аутентификацию
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
          if (state is AuthError) {
            // Отображение сообщения об ошибке, если пользователь не аутентифицирован
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            //Отображение индикатора загрузки
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            // Отображение формы регистрации, если пользователь не аутентифицирован
            return const SignUpForm();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
