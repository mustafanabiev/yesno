import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesno/modules/cards/cubit/card_cubit.dart';
import 'package:yesno/modules/cards/cubit/premium_cubit.dart';
import 'package:yesno/modules/main/cubit/main_cubit.dart';
import 'package:yesno/modules/main/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CardCubit()..loadFromPreferences(),
        ),
        BlocProvider(
          create: (context) => PremiumCubit()..loadPremiumState(),
        ),
        BlocProvider(
          create: (context) => MainCubit()..loadAuthState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YESNO',
        theme: ThemeData.dark(useMaterial3: true),
        home: SplashView(prefs: prefs),
      ),
    );
  }
}
