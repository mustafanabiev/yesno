import 'package:flutter/material.dart';
import 'package:yesno/modules/main/get_start_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      _navigateToHome();
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const GetStartView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
