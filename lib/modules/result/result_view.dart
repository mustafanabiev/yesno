import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yesno/modules/cubit/card_cubit.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'RESULT',
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CardCubit, CardState>(
          builder: (context, state) {
            return Column(
              children: [
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: 121,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xffF9F9F9).withOpacity(0.05),
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff6069D7),
                        Color(0xff3A408E),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${state.yesCount}',
                        style: const TextStyle(
                          fontFamily: 'Onest',
                          fontWeight: FontWeight.w400,
                          fontSize: 48,
                          color: Color(0xffE5EEFF),
                          height: 0,
                        ),
                      ),
                      const Text(
                        'Yes',
                        style: TextStyle(
                          fontFamily: 'Brawler',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xffE5EEFF),
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 121,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xffF9F9F9).withOpacity(0.05),
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffC64A4F),
                        Color(0xffB52B31),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${state.noCount}',
                        style: const TextStyle(
                          fontFamily: 'Onest',
                          fontWeight: FontWeight.w400,
                          fontSize: 48,
                          color: Color(0xffE5EEFF),
                          height: 0,
                        ),
                      ),
                      const Text(
                        'No',
                        style: TextStyle(
                          fontFamily: 'Brawler',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xffE5EEFF),
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          },
        ),
      ),
    );
  }
}
