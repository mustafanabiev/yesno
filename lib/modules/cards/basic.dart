import 'dart:async';

import 'package:flutter/material.dart';

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _countdown > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff3A408E),
                          Color(0xff6069D7),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _countdown.toString(),
                        style: const TextStyle(
                          fontFamily: 'Onest',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xffF9F9F9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/images/question.png',
                    height: 276,
                  ),
                ],
              )
            : Container(width: 305, height: 200, color: Colors.red)
      ],
    );
  }
}
