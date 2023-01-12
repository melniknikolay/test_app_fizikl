import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../error_page/error_page.dart';
import '../home_page/home_page.dart';

import 'widgets/sign_in_form.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Переход на главную, если пользователь прошел аутентификацию
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }
          if (state is AuthError) {
            // Отображение сообщения об ошибке, если пользователь не аутентифицирован и переход на страницу с грустным Илончиком
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => const ErrorPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              //Отображение индикатора загрузки
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Отображение формы регистрации, если пользователь не аутентифицирован
              return const SignInForm();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
