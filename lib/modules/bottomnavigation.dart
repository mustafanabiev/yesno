import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    requestNotificationPermission();
    super.initState();
  }

  void requestNotificationPermission() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {},
      ),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

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
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9).withOpacity(0.05),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: const Color(0xffF9F9F9).withOpacity(0.1),
          ),
        ),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem('assets/svg/card.svg', 0, 'Cards'),
            navItem('assets/svg/results.svg', 1, 'Results'),
            navItem('assets/svg/settings.svg', 2, 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget navItem(String svg, int index, String label) {
    return GestureDetector(
      onTap: () => setState(() {
        currentIndex = index;
      }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svg,
            color: currentIndex == index
                ? const Color(0xffF9F9F9)
                : const Color(0xffC4C9DB),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Onest',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: currentIndex == index
                  ? const Color(0xffF9F9F9)
                  : const Color(0xffC4C9DB),
            ),
          ),
        ],
      ),
    );
  }
}
