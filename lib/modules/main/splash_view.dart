import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesno/modules/bottomnavigation.dart';
import 'package:yesno/modules/main/get_start_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      if (prefs.getBool('isAuth') != null && prefs.getBool('isAuth') != false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const Bottomnavigation(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const GetStartView(),
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset(
              'assets/images/logoyesno.png',
              width: 180,
            ),
            const Spacer(),
            const Text(
              'Fate of Fortune',
              style: TextStyle(
                fontFamily: 'Onest',
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
