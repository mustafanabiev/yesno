import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'SETTINGS',
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
        child: Column(
          children: [
            _switchValue == false
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff3A408E),
                          Color(0xff6069D7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xffF9F9F9).withOpacity(0.05),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/ph_crown-fill.svg'),
                          const SizedBox(width: 8),
                          const Text(
                            'Subscription management',
                            style: TextStyle(
                              fontFamily: 'Onest',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xffF9F9F9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9).withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xffF9F9F9).withOpacity(0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/privacy.svg'),
                    const SizedBox(width: 8),
                    const Text(
                      'Privacy policy',
                      style: TextStyle(
                        fontFamily: 'Onest',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xffF9F9F9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9).withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xffF9F9F9).withOpacity(0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/terms.svg'),
                    const SizedBox(width: 8),
                    const Text(
                      'Terms of Use',
                      style: TextStyle(
                        fontFamily: 'Onest',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xffF9F9F9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9).withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xffF9F9F9).withOpacity(0.05),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/notific.svg'),
                    const SizedBox(width: 8),
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontFamily: 'Onest',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xffF9F9F9),
                      ),
                    ),
                    const Spacer(),
                    Transform.scale(
                      scale: 0.9,
                      child: CupertinoSwitch(
                        activeColor: const Color(0xff3A408E),
                        trackColor: const Color(0xffC4C9DB),
                        thumbColor: const Color(0xffF9F9F9),
                        value: _switchValue,
                        onChanged: (newValue) {
                          setState(() {
                            _switchValue = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
