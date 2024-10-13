import 'package:equatable/equatable.dart';

enum LoginStep { initial, loading, succues, error }

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
