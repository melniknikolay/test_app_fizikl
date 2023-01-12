part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Когда пользователь входит в систему с помощью электронной почты и пароля, вызывается это событие, и [AuthRepository] вызывается для входа пользователя.
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

// Когда пользователь регистрируется с помощью электронной почты и пароля, вызывается это событие, и [AuthRepository] вызывается для регистрации пользователя.
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);
}

// Когда пользователь выходит из системы, вызывается это событие и вызывается [AuthRepository] для выхода пользователя.
class SignOutRequested extends AuthEvent {}
