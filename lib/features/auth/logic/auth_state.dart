class AuthState {}
class AuthInitialState extends AuthState{}
class AuthLoadingState extends AuthState{}
class AuthSuccessState extends AuthState{}
class AuthErrorState extends AuthState{
 final String errorMsg;
  AuthErrorState({required this.errorMsg});
}

//register states
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String errorMsg;
  RegisterErrorState({required this.errorMsg});
}