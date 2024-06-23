import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yesno/modules/cards/basic.dart';
import 'package:yesno/modules/cards/premium.dart';
import 'package:yesno/modules/cards/cubit/premium_cubit.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
                    BlocBuilder<PremiumCubit, bool>(
                      builder: (context, state) {
                        if (state) {
                          return const Premium();
                        } else {
                          return const PremiumWidget();
                        }
                      },
                    ),
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
