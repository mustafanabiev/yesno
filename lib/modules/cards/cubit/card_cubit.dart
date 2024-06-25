import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit()
      : super(const CardState(
          yesCount: 0,
          noCount: 0,
          restart: true,
        )) {
    loadFromPreferences();
  }

  void reset(bool reset) {
    emit(state.copyWith(restart: reset));
  }

  void updateCount(bool isYes) async {
    if (isYes) {
      emit(state.copyWith(yesCount: state.yesCount + 1));
    } else {
      emit(state.copyWith(noCount: state.noCount + 1));
    }
    await _saveToPreferences();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('yesCount', state.yesCount);
    await prefs.setInt('noCount', state.noCount);
  }

  Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final yesCount = prefs.getInt('yesCount') ?? 0;
    final noCount = prefs.getInt('noCount') ?? 0;
    emit(state.copyWith(yesCount: yesCount, noCount: noCount));
  }
}
