import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood_architecture/presentation/screens/login_screen.dart';

// Trasformare una classe in un provider Riverpod offre numerosi vantaggi:

// Singleton: Gestione automatica delle istanze.
// Dependency Injection: Iniezione delle dipendenze senza sforzo.
// Testabilità: Facile mocking e testing.
// Modularità: Codice organizzato e riutilizzabile.
// Flessibilità: Supporto per diversi tipi di stato e provider.
// Accesso senza BuildContext: Maggiore libertà nell'accesso ai provider.

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Architecture',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}
