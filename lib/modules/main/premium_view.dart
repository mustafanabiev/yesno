import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yesno/modules/cards/cubit/premium_cubit.dart';

class PremiumView extends StatelessWidget {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                'assets/images/prem.png',
                height: 280,
              ),
              const Spacer(flex: 2),
              const Text(
                'Premium',
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Color(0xffF9F9F9),
                ),
              ),
              const Text(
                'Get full access to answers to your questions from the Ouija Board with a premium subscription for \$0.99',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xffC4C9DB),
                ),
              ),
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () {
                  context.read<PremiumCubit>().premium();
                  Navigator.pop(context);
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
                      'GET FOR \$0.99',
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
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xffC4C9DB),
                    ),
                  ),
                  Text(
                    'Restore',
                    style: TextStyle(
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xffC4C9DB),
                    ),
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xffC4C9DB),
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
