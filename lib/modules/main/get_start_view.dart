import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesno/modules/bottomnavigation.dart';

class GetStartView extends StatelessWidget {
  const GetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isAuth', true);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Bottomnavigation(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 28,
                    color: Color(0xffF9F9F9),
                  ),
                ),
              ),
              const Spacer(flex: 3),
              Image.asset(
                'assets/images/logoyesno.png',
                width: 180,
              ),
              const Spacer(flex: 2),
              const Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(
                width: 343,
                child: Text(
                  'Here you can get the answer to any question, the answer to which will be yes or no. Just focus on your question, choose the method - cards or the Ouiji board, and get the answer!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF8F8F8),
                    fontSize: 16,
                    fontFamily: 'Onest',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isAuth', true);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Bottomnavigation(),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff3A408E),
                        Color(0xff6069D7),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontFamily: 'Onest',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFFF9F9F9),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Terms of Use',
                    style: TextStyle(
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Color(0xffF9F9F9),
                    ),
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Color(0xffF9F9F9),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
