// presentation/providers/reminder_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood_architecture/data/repositories/reminder.repository.dart';
import 'reminder_state.dart';

final reminderNotifierProvider =
    StateNotifierProvider<ReminderNotifier, ReminderState>((ref) {
      final reminderRepository = ref.watch(reminderRepositoryProvider);
      return ReminderNotifier(reminderRepository);
    });

class ReminderNotifier extends StateNotifier<ReminderState> {
  final ReminderRepository _reminderRepository;

  ReminderNotifier(this._reminderRepository) : super(ReminderState());

  Future<void> fetchReminders() async {
    try {
      // Imposta lo stato di caricamento
      state = state.copyWith(isLoading: true, error: null);

      // Recupera i promemoria dal repository
      final reminders = await _reminderRepository.getReminders();

      // Aggiorna lo stato con i promemoria recuperati
      state = state.copyWith(reminders: reminders, isLoading: false);
    } catch (e) {
      // Gestisci l'errore
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
