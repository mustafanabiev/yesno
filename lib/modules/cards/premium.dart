import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yesno/modules/cards/cubit/card_cubit.dart';
import 'package:yesno/modules/main/premium_view.dart';

class Premium extends StatefulWidget {
  const Premium({Key? key}) : super(key: key);

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
  }

  List<String> _selectRandomImageList() {
    final random = Random();
    return random.nextBool()
        ? ['oujia_board']
        : ['oujia_no']; // Example, adjust as needed
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
            _showQuestionImage = true;
            _countdown = 5;
            _currentImageIndex = 0;
            _selectedImageList = _selectRandomImageList();
          }
        });
      },
    );
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--;
        } else if (_countdown == 1) {
          _countdown--;
          _showQuestionImage = false;
        } else {
          _timer?.cancel();
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

  void _onQuestionImageTap() {
    if (!_showQuestionImage) return;
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_countdown > 0)
          Column(
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
              GestureDetector(
                onTap: _onQuestionImageTap,
                child: Image.asset(
                  'assets/images/question.png',
                  height: 276,
                ),
              ),
            ],
          )
        else if (!_showQuestionImage)
          Center(
            child: GestureDetector(
              onTap: () {
                _startImageSlider();
              },
              child: _selectedImageList[_currentImageIndex] == 'oujia_board'
                  ? const YesPage()
                  : const NoPage(),
            ),
          ),
      ],
    );
  }
}

class YesPage extends StatefulWidget {
  const YesPage({super.key});

  @override
  State<YesPage> createState() => _YesPageState();
}

class _YesPageState extends State<YesPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _upwardController;
  late AnimationController _thirdController;
  late Animation<double> _translationXAnimation;
  late Animation<double> _translationYAnimation;
  late Animation<double> _rotationAnimation;

  late Animation<double> _upwardTranslationXAnimation;
  late Animation<double> _upwardTranslationYAnimation;
  late Animation<double> _secondRotationAnimation;

  late Animation<double> _thirdTranslationXAnimation;
  late Animation<double> _thirdTranslationYAnimation;
  late Animation<double> _thirdRotationAnimation;

  late String _currentBackgroundImage;

  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        if (_controller.value >= 1.0 && _animationStarted) {
          setState(() {
            _currentBackgroundImage = 'assets/images/oujia_y.png';
          });
          _upwardController.forward();
        }
      });

    _upwardController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        if (_upwardController.value >= 1.0) {
          setState(() {
            _currentBackgroundImage = 'assets/images/oujia_ye.png';
          });
          _thirdController.forward();
        }
      });

    _thirdController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        if (_thirdController.value >= 1.0) {
          setState(() {
            _currentBackgroundImage = 'assets/images/oujia_yes.png';
          });
        }
      });

    _translationXAnimation = Tween<double>(
      begin: -1.8,
      end: -0.43,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _translationYAnimation = Tween<double>(
      begin: -0.9,
      end: -1.32,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.59,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _upwardTranslationXAnimation = Tween<double>(
      begin: -0.43,
      end: -1.97,
    ).animate(CurvedAnimation(
      parent: _upwardController,
      curve: Curves.easeInOut,
    ));

    _upwardTranslationYAnimation = Tween<double>(
      begin: -1.32,
      end: -2.05,
    ).animate(CurvedAnimation(
      parent: _upwardController,
      curve: Curves.easeInOut,
    ));

    _secondRotationAnimation = Tween<double>(
      begin: 0.59,
      end: -0.04,
    ).animate(CurvedAnimation(
      parent: _upwardController,
      curve: Curves.easeInOut,
    ));

    _thirdTranslationXAnimation = Tween<double>(
      begin: -1.97,
      end: -2.02, // Slightly to the right for the third point
    ).animate(CurvedAnimation(
      parent: _thirdController,
      curve: Curves.easeInOut,
    ));

    _thirdTranslationYAnimation = Tween<double>(
      begin: -2.05,
      end: -1.56, // Further upward for the third point
    ).animate(CurvedAnimation(
      parent: _thirdController,
      curve: Curves.easeInOut,
    ));

    _thirdRotationAnimation = Tween<double>(
      begin: -0.04,
      end: -0.1, // Rotation value for the third point
    ).animate(CurvedAnimation(
      parent: _thirdController,
      curve: Curves.easeInOut,
    ));

    _currentBackgroundImage = 'assets/images/oujia_board.png';
  }

  @override
  void dispose() {
    _controller.dispose();
    _upwardController.dispose();
    _thirdController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    context.read<CardCubit>().updateCount(true);
    setState(() {
      _animationStarted = true;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _startAnimation,
        child: Container(
          width: double.infinity,
          height: 343,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_currentBackgroundImage),
            ),
          ),
          child: AnimatedBuilder(
            animation: Listenable.merge(
                [_controller, _upwardController, _thirdController]),
            builder: (context, child) {
              return Align(
                alignment: Alignment.bottomRight,
                child: FractionalTranslation(
                  translation: Offset(
                    _controller.isCompleted
                        ? (_upwardController.isCompleted
                            ? _thirdTranslationXAnimation.value
                            : _upwardTranslationXAnimation.value)
                        : _translationXAnimation.value,
                    _controller.isCompleted
                        ? (_upwardController.isCompleted
                            ? _thirdTranslationYAnimation.value
                            : _upwardTranslationYAnimation.value)
                        : _translationYAnimation.value,
                  ),
                  child: Transform.rotate(
                    angle: _controller.isCompleted
                        ? (_upwardController.isCompleted
                            ? _thirdRotationAnimation.value
                            : _secondRotationAnimation.value)
                        : _rotationAnimation.value,
                    child: SvgPicture.asset('assets/svg/indicator.svg'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NoPage extends StatefulWidget {
  const NoPage({super.key});

  @override
  State<NoPage> createState() => _NoPageState();
}

class _NoPageState extends State<NoPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _secondController;
  late Animation<double> _translationXAnimation;
  late Animation<double> _translationYAnimation;
  late Animation<double> _secondTranslationXAnimation;
  late Animation<double> _secondTranslationYAnimation;
  late Animation<double>? _rotationAnimation;

  late String _currentBackgroundImage;
  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        if (_controller.value >= 0.5 && _controller.value < 1.0) {
          setState(() {
            _currentBackgroundImage = 'assets/images/oujia_n.png';
          });
        } else if (_controller.value >= 1.0 && _animationStarted) {
          _secondController.forward();
        }
      });

    _secondController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        if (_secondController.value >= 1.0) {
          setState(() {
            _currentBackgroundImage = 'assets/images/oujia_no.png';
          });
        }
      });

    _translationXAnimation = Tween<double>(
      begin: -1.8,
      end: -3.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    _translationYAnimation = Tween<double>(
      begin: -0.9,
      end: -1.15,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    _secondTranslationXAnimation = Tween<double>(
      begin: -3.2,
      end: -2.952,
    ).animate(CurvedAnimation(
      parent: _secondController,
      curve: Curves.easeInOut,
    ));

    _secondTranslationYAnimation = Tween<double>(
      begin: -1.15,
      end: -1.32,
    ).animate(CurvedAnimation(
      parent: _secondController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: -0.6,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _currentBackgroundImage = 'assets/images/oujia_board.png';
  }

  @override
  void dispose() {
    _controller.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    context.read<CardCubit>().updateCount(false);
    setState(() {
      _animationStarted = true;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _startAnimation,
        child: Container(
          width: double.infinity,
          height: 343,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_currentBackgroundImage),
            ),
          ),
          child: AnimatedBuilder(
            animation: Listenable.merge([_controller, _secondController]),
            builder: (context, child) {
              return Align(
                alignment: Alignment.bottomRight,
                child: FractionalTranslation(
                  translation: Offset(
                    _controller.value < 1.0
                        ? _translationXAnimation.value
                        : _secondTranslationXAnimation.value,
                    _controller.value < 1.0
                        ? _translationYAnimation.value
                        : _secondTranslationYAnimation.value,
                  ),
                  child: Transform.rotate(
                    angle: _controller.value < 1.0
                        ? _rotationAnimation!.value
                        : -0.6,
                    child: SvgPicture.asset('assets/svg/indicator.svg'),
                  ),
                ),
              );
            },
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
