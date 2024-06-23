import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumCubit extends Cubit<bool> {
  PremiumCubit() : super(false) {
    loadFromPreferences();
  }

  Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final premium = prefs.getBool('premium') ?? false;
    emit(premium);
  }

  Future<void> setPremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('premium', true);
    emit(true);
  }
}
