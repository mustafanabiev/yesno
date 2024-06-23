import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'premium_state.dart';

class PremiumCubit extends Cubit<PremiumState> {
  PremiumCubit() : super(PremiumState(premium: false));

  void loadPremiumState() async {
    final prefs = await SharedPreferences.getInstance();
    final isPremium = prefs.getBool('premium') ?? false;
    emit(state.copyWith(premium: isPremium));
  }

  void premium() async {
    emit(state.copyWith(premium: true));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('premium', true);
  }
}
