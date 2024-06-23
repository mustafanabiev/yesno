part of 'premium_cubit.dart';

class PremiumState {
  PremiumState({
    required this.premium,
  });

  final bool premium;

  PremiumState copyWith({
    bool? premium,
  }) {
    return PremiumState(
      premium: premium ?? this.premium,
    );
  }
}
