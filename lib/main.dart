import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yesno/modules/cubit/card_cubit.dart';
import 'package:yesno/modules/cubit/premium_cubit.dart';
import 'package:yesno/modules/main/splash_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CardCubit()..loadFromPreferences(),
        ),
        BlocProvider(
          create: (context) => PremiumCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YESNO',
        theme: ThemeData.dark(useMaterial3: true),
        home: const SplashView(),
      ),
    );
  }
}
