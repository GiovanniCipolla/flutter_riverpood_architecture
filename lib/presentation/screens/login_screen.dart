// presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood_architecture/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpood_architecture/presentation/providers/auth_state.dart';

// Nota bene ; facendo cosi , al cambiare dello stato si aggiorna tutto il widget.
// se vogliamo che si aggiorni solo una piccola parte di codice , usare anche qui il consumer =
//  // Usa Consumer per isolare la ricostruzione
// Consumer(
//   builder: (context, ref, child) {
//     final authState = ref.watch(authNotifierProvider);
//     return Text(
//       authState.isLoggedIn ? 'Sei loggato!' : 'Non sei loggato',
//       style: const TextStyle(fontSize: 16),
//     );
//   },

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ascolta lo stato di autenticazione
    final authState = ref.watch(authNotifierProvider);

    // Ascolta i cambiamenti di stato per navigare alla schermata di default
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.isLoggedIn) {
        // Naviga alla schermata di default quando l'utente è loggato
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Placeholder()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Email')),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .read(authNotifierProvider.notifier)
                      .login('admin', 'admin');
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Errore: $e')));
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
