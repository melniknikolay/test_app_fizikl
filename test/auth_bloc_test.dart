import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:test_app_fizikl/bloc/auth/auth_bloc.dart';
import 'package:test_app_fizikl/data/repositories/i_auth_repository.dart';


class MockFireAuth implements IAuthRepository {
  final _firebaseAuth = MockFirebaseAuth();
  @override
  Future<void> signIn({required String email, required String password}) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
}

void main() async {

  group('AuthBloc Test', () {
    late AuthBloc authBloc;
    IAuthRepository authRepository = MockFireAuth();
    setUp(() {
      authBloc = AuthBloc(authRepository: authRepository);
    });

    blocTest<AuthBloc, AuthState>(
      'SignIn',
      build: () => authBloc,
      act: (bloc) => bloc.add(SignInRequested('1111@mail.test', '12345678')),
      expect: () => [
        Loading(),
        Authenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'SignUp',
      build: () => authBloc,
      act: (bloc) => bloc.add(SignUpRequested('1111@mail.test', '12345678')),
      expect: () => [
        Loading(),
        Authenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
        'SignOut',
        build: () => authBloc,
        act: (bloc) => bloc.add(SignOutRequested()),
        expect: () => [
          Loading(),
          UnAuthenticated(),
        ]
    );
  });
}