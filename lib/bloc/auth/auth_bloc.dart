import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/i_auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // При нажатии кнопки Входа, мы отправляем событие SignInRequested в AuthBloc, чтобы обработать его и передать состояние аутентификации, если пользователь прошел аутентификацию.
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // При нажатии кнопки Регистрации, мы отправляем событие SignUpRequest в AuthBloc, чтобы обработать его и передать состояние аутентификации, если пользователь прошел аутентификацию.
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // При нажатии кнопки Выход, мы отправляем событие SignOutRequested в AuthBloc, чтобы обработать его и передать состояние UnAuthenticated.
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}
