import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yesno/modules/cards/cards_view.dart';
import 'package:yesno/modules/result/result_view.dart';
import 'package:yesno/modules/setting/settings_view.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int currentIndex = 0;
  bool currentIcon = false;

  final List<Widget> pages = <Widget>[
    const CardsView(),
    const ResultView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        child: pages[currentIndex],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: const Color(0xffF9F9F9).withOpacity(0.1),
          ),
        ),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BottomNavigationBar(
            enableFeedback: false,
            selectedItemColor: const Color(0xffF9F9F9),
            unselectedItemColor: const Color(0xffC4C9DB),
            onTap: (value) => setState(() {
              currentIndex = value;
            }),
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Onest',
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            backgroundColor: const Color(0xFFF9F9F9).withOpacity(0.05),
            items: [
              BottomNavigationBarItem(
                icon: currentIconMethod('assets/svg/card.svg', 0),
                label: 'Cards',
              ),
              BottomNavigationBarItem(
                icon: currentIconMethod('assets/svg/results.svg', 1),
                label: 'Results',
              ),
              BottomNavigationBarItem(
                icon: currentIconMethod('assets/svg/settings.svg', 2),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  SvgPicture currentIconMethod(String svg, int index) => SvgPicture.asset(svg,

      // ignore: deprecated_member_use
      color: currentIndex == index
          ? const Color(0xffF9F9F9)
          : const Color(0xffC4C9DB));
}
