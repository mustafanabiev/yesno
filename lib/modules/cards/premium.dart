import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yesno/modules/cards/cubit/card_cubit.dart';
import 'package:yesno/modules/cards/cubit/premium_cubit.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  int _countdown = 5;
  Timer? _timer;

  int _currentImageIndex = 0;
  Timer? _sliderTimer;
  late List<String> _selectedImageList;
  bool _showQuestionImage = true;

  @override
  void initState() {
    super.initState();
    _selectedImageList = _selectRandomImageList();
    _startCountdown();
  }

  List<String> _selectRandomImageList() {
    final random = Random();
    return random.nextBool() ? yesImage : noImage;
  }

  void _startImageSlider() {
    _sliderTimer?.cancel();
    _sliderTimer = Timer(
      Duration(
        milliseconds:
            (_currentImageIndex == _selectedImageList.length - 1) ? 5000 : 600,
      ),
      () {
        setState(() {
          if (_currentImageIndex < _selectedImageList.length - 1) {
            _currentImageIndex++;
            _startImageSlider();
          } else {
            if (_selectedImageList == yesImage) {
              context.read<CardCubit>().updateCount(true);
            } else {
              context.read<CardCubit>().updateCount(false);
            }

            _showQuestionImage = true;
            _countdown = 5;
            _currentImageIndex = 0;
            _selectedImageList = _selectRandomImageList();
            _startCountdown();
          }
        });
      },
    );
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
          _showQuestionImage = false;
          _startImageSlider();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sliderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _showQuestionImage
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
            : Center(
                child: SvgPicture.asset(
                  'assets/images/${_selectedImageList[_currentImageIndex]}.svg',
                ),
              ),
      ],
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
                  context.read<PremiumCubit>().setPremium();
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

List<String> yesImage = [
  'oujia_board',
  'yes1',
  'yes2',
  'yes3',
  'yes4',
  'yes5',
  'yes6',
];

List<String> noImage = ['oujia_board', 'no1', 'no2', 'no3', 'no4'];
