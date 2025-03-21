// presentation/providers/auth_state.dart
class AuthState {
  final bool isLoggedIn;

  AuthState({this.isLoggedIn = false});

  // Metodo per creare una copia dello stato con valori aggiornati
  AuthState copyWith({bool? isLoggedIn}) {
    return AuthState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }
}
