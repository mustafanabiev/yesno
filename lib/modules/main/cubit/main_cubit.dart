import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState(isAuth: false)) {
    // loadAuthState();
  }

  Future<void> loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool('isAuth') ?? false;
    emit(state.copyWith(isAuth: isAuth));
  }

  Future<void> setAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuth', true);
    emit(state.copyWith(isAuth: true));
  }
}
