import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'data/repositories/firebase_auth_repository.dart';
import 'data/repositories/i_auth_repository.dart';
import 'presentation/home_page/home_page.dart';
import 'presentation/sign_in_page/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IAuthRepository>(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<IAuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // Если в snapshot есть пользовательские данные, значит, они уже вошел в систему.
              if (snapshot.hasData) {
                return const HomePage();
              }
              // В противном случае он не вошел в систему. Показать страницу входа.
              return const SignIn();
            },
          ),
        ),
      ),
    );
  }
}
