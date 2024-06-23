part of 'card_cubit.dart';

class CardState {
  const CardState({
    required this.yesCount,
    required this.noCount,
    required this.premium,
  });

  final int yesCount;
  final int noCount;
  final bool premium;

  CardState copyWith({
    int? yesCount,
    int? noCount,
    bool? premium,
  }) {
    return CardState(
      yesCount: yesCount ?? this.yesCount,
      noCount: noCount ?? this.noCount,
      premium: premium ?? this.premium,
    );
  }
}
