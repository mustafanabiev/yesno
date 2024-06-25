part of 'card_cubit.dart';

class CardState {
  const CardState({
    required this.yesCount,
    required this.noCount,
    required this.restart,
  });

  final int yesCount;
  final int noCount;
  final bool restart;

  CardState copyWith({
    int? yesCount,
    int? noCount,
    bool? restart,
  }) {
    return CardState(
      yesCount: yesCount ?? this.yesCount,
      noCount: noCount ?? this.noCount,
      restart: restart ?? this.restart,
    );
  }
}
