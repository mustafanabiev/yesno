part of 'main_cubit.dart';

class MainState {
  MainState({required this.isAuth});

  final bool isAuth;

  MainState copyWith({
    bool? isAuth,
  }) {
    return MainState(
      isAuth: isAuth ?? this.isAuth,
    );
  }
}
