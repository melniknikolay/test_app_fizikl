import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../sign_in_page/sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получение пользователя из FirebaseAuth
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Переход к экрану входа когда пользователь разлогинивается
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                height: 300,
                width: 300,
                imageUrl:
                    'https://skr.sh/s/250422/xnoyYOGB.png?download=1&name=%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%2011-01-2023%2017:56:19.png',
                progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                  margin: const EdgeInsets.all(100),
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Дай угадаю, твой email: \n ${user?.email}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  key: const ValueKey('SignOutButton'),
                  child: const Text('Выйти'),
                  onPressed: () {
                    // Signing out the user
                    context.read<AuthBloc>().add(SignOutRequested());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
