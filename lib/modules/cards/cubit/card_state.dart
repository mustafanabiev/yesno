part of 'card_cubit.dart';

class CardState {
  const CardState({
    required this.yesCount,
    required this.noCount,
  });

  final int yesCount;
  final int noCount;

  CardState copyWith({
    int? yesCount,
    int? noCount,
  }) {
    return CardState(
      yesCount: yesCount ?? this.yesCount,
      noCount: noCount ?? this.noCount,
    );
  }
}
