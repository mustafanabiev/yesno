import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yesno/modules/cards/basic.dart';
import 'package:yesno/modules/cards/premium.dart';
import 'package:yesno/modules/cards/cubit/premium_cubit.dart';
import 'package:yesno/modules/main/premium_view.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  @override
  void initState() {
    context.read<PremiumCubit>().loadPremiumState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xff0A0E16),
        appBar: AppBar(
          backgroundColor: const Color(0xff0A0E16),
          automaticallyImplyLeading: false,
          title: const Text(
            'CARDS',
            style: TextStyle(
              fontFamily: 'Onest',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(0xffF9F9F9),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 38,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff191C2A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.all(4),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff3A408E),
                        Color(0xff6069D7),
                      ],
                    ),
                  ),
                  unselectedLabelColor: const Color(0xffC4C9DB),
                  labelColor: const Color(0xffF9F9F9),
                  labelStyle: const TextStyle(
                    fontFamily: 'Onest',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: const [
                    Tab(text: "BASIC"),
                    Tab(text: "PREMIUM"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const Basic(),
                    context.watch<PremiumCubit>().state.premium
                        ? const Premium()
                        : const PremiumWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PremiumWidget extends StatelessWidget {
  const PremiumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset(
            'assets/images/question.png',
            height: 276,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(flex: 7),
              SvgPicture.asset('assets/svg/key.svg'),
              const Spacer(),
              const Text(
                'Premium',
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Color(0xffF9F9F9),
                ),
              ),
              const Spacer(),
              const Text(
                'Get full access to answers to your questions from the Ouija Board with a premium subscription for \$0.99',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xffC4C9DB),
                  height: 0,
                ),
              ),
              const Spacer(flex: 4),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PremiumView(),
                    ),
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
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
