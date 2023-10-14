part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoadingLogin extends AuthState {}

class SuccessLogin extends AuthState {}

class ErrorLogin extends AuthState {}

class LoadingCreateAccount extends AuthState {}

class SuccessCreateAccount extends AuthState {}

class ErrorCreateAccount extends AuthState {}

class LoadingProfile extends AuthState {}

class SuccessProfile extends AuthState {}

class ErrorProfile extends AuthState {}
