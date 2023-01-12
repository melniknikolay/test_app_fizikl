part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

// При нажатии кнопки входа или регистрации, состояние сначала изменяется на Загрузка, а затем на Аутентификация.
class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

// Когда пользователь аутентифицирован, состояние меняется на Аутентифицирован.
class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// Это начальное состояние блока. Когда пользователь не аутентифицирован, состояние изменяется на Unauthenticated.
class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// Если возникает какая-либо ошибка, состояние изменяется на AuthError.
class AuthError extends AuthState {
  final String error;

  AuthError(this.error);

  @override
  List<Object?> get props => [error];
}
