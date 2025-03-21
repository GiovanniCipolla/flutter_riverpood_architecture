// presentation/providers/auth_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood_architecture/core/token_manager.dart';
import 'package:flutter_riverpood_architecture/data/models/token.dart';
import 'package:flutter_riverpood_architecture/data/repositories/auth_repository.dart';
import 'auth_state.dart';

// Tipo di Provider	Cosa Fa	Quando Usarlo
// Provider	                 ----- Fornisce un'istanza o un valore immutabile.	Per servizi o oggetti che non cambiano nel tempo.
// StateProvider             -----	Gestisce un singolo valore che può cambiare nel tempo.	Per stati semplici (ad esempio, un contatore o un flag).
// StateNotifierProvider     -----	Gestisce uno stato complesso utilizzando StateNotifier.	Per stati con logica di business (ad esempio, autenticazione).
// FutureProvider            -----	Gestisce un valore asincrono.	Per operazioni asincrone (ad esempio, caricamento di dati).
// StreamProvider	           ------ Gestisce un flusso di dati.	Per dati che cambiano nel tempo (ad esempio, notifiche in tempo reale).
// ChangeNotifierProvider    ------ Gestisce uno stato utilizzando ChangeNotifier.	Solo per migrazioni da Provider classico. Preferisci StateNotifierProvider.
// FamilyProvider	Crea       ------ un provider che dipende da un parametro.	Per stati che dipendono da input esterni (ad esempio, un ID utente).
// AutoDisposeProvider       ------ Dispone automaticamente del provider quando non è più utilizzato.	Per stati temporanei (ad esempio, una schermata di dettaglio).

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    // qui è mock , altrimenti avremmo usato il repository
    try {
      if (email == 'admin' && password == 'admin') {
        final token = Token(
          accessToken: 'mock_token',
          refreshToken: 'mock_refresh_token',
        );
        await TokenManager.setToken(token); // Salva il token
        state = state.copyWith(isLoggedIn: true); // Aggiorna lo stato
      }
    } catch (e) {
      state = state.copyWith(
        isLoggedIn: false,
      ); // Aggiorna lo stato in caso di errore
      throw Exception('Errore durante il login: $e');
    }
  }

  Future<void> logout() async {
    await TokenManager.clearToken(); // Cancella il token
    state = state.copyWith(isLoggedIn: false); // Aggiorna lo stato
  }
}
