import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yesno/modules/cards/cubit/card_cubit.dart';

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
  }

  List<String> _selectRandomImageList() {
    final random = Random();
    return random.nextBool() ? ['ouija_board'] : ['ouija_no'];
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
          context.read<CardCubit>().reset(false);
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
  void didChangeDependencies() {
    context.read<CardCubit>().reset(true);
    super.didChangeDependencies();
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
    return BlocBuilder<CardCubit, CardState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.restart)
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
            else
              Center(
                child: GestureDetector(
                  onTap: () {
                    _startImageSlider();
                  },
                  child: const SizedBox(
                    height: 343,
                    child: LetterBoard(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class LetterBoard extends StatefulWidget {
  const LetterBoard({super.key});

  @override
  State<LetterBoard> createState() => _LetterBoardState();
}

class _LetterBoardState extends State<LetterBoard> {
  String _currentWord = "";
  List<String> _letters = [];
  final Map<String, Offset> _letterPositions = {
    'Y': const Offset(239, 142),
    'E': const Offset(117, 78),
    'S': const Offset(108, 115),
    'N': const Offset(16, 165),
    'O': const Offset(31, 150)
  };

  void _selectRandomWord() {
    final random = Random();
    if (random.nextBool()) {
      context.read<CardCubit>().updateCount(true);
      _letters = ['Y', 'E', 'S']; // YES
    } else {
      context.read<CardCubit>().updateCount(false);
      _letters = ['N', 'O']; // NO
    }
  }

  int _currentLetterIndex = 0;
  Timer? _movementTimer;
  Timer? _resetTimer;
  Offset _indicatorPosition = const Offset(130, 170);
  double _rotationAngle = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _movementTimer?.cancel();
    _resetTimer?.cancel();
    super.dispose();
  }

  void _startMovement() {
    // 1
    // setState(() {
    //   // Move the indicator to the first letter's position immediately
    //   _indicatorPosition = _letterPositions[_letters[_currentLetterIndex]]!;
    //   _updateRotationAngle(_letters[_currentLetterIndex]);
    //   _currentWord += _letters[_currentLetterIndex];
    //   _currentLetterIndex++;
    // });

    _movementTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentLetterIndex < _letters.length) {
        setState(() {
          _indicatorPosition = _letterPositions[_letters[_currentLetterIndex]]!;
          _updateRotationAngle(_letters[_currentLetterIndex]);
        });

        // Delay the appearance of the letter
        Timer(const Duration(milliseconds: 600), () {
          if (_currentLetterIndex < _letters.length) {
            setState(() {
              _currentWord += _letters[_currentLetterIndex];
              _currentLetterIndex++;
            });
          }
        });
      } else {
        _movementTimer?.cancel();
        _resetTimer = Timer(const Duration(seconds: 5), () {
          context.read<CardCubit>().reset(true);
          setState(() {
            _currentWord = "";
            _currentLetterIndex = 0;
            _indicatorPosition = const Offset(130, 170);
            _rotationAngle = 0;
          });
        });
      }
    });
  }

  void _updateRotationAngle(String letter) {
    if (letter == 'Y') {
      _rotationAngle = 30 * 3.14159 / 180; // Rotate by 30 degrees
    } else if (letter == 'S') {
      _rotationAngle = -5 * 3.14159 / 180; // Rotate by -5 degrees
    } else if (letter == 'N') {
      _rotationAngle = -35 * 3.14159 / 180; // Rotate by -35 degrees
    } else if (letter == 'O') {
      _rotationAngle = -25 * 3.14159 / 180; // Rotate by -25 degrees
    } else {
      _rotationAngle = 0; // No rotation for other letters
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            _selectRandomWord();
            _currentLetterIndex = 0;
            _currentWord = "";
            _startMovement();
          },
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/oujia_board.png'),
              ),
            ),
            child: Stack(
              children: <Widget>[
                ..._buildLettersPositions(),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  top: _indicatorPosition.dy,
                  left: _indicatorPosition.dx,
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 600),
                    turns: _rotationAngle / (2 * pi),
                    child: Image.asset(
                      'assets/images/indicator.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 65,
                  left: 120,
                  child: Text(
                    _currentWord,
                    style: const TextStyle(
                      color: Color(0xFFF8F8F8),
                      fontSize: 32,
                      fontFamily: 'Brawler',
                      fontWeight: FontWeight.w700,
                      height: 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLettersPositions() {
    return [
      Positioned(
        top: 130,
        left: 50,
        child: Image.asset('assets/letters/A.png'),
      ),
      Positioned(
        top: 115,
        left: 70,
        child: Image.asset('assets/letters/B.png'),
      ),
      Positioned(
        top: 103,
        left: 95,
        child: Image.asset('assets/letters/c.png'),
      ),
      Positioned(
        top: 96,
        left: 122,
        child: Image.asset('assets/letters/D.png'),
      ),
      Positioned(
        top: 92,
        left: 150,
        child: Image.asset('assets/letters/E.png'),
      ),
      Positioned(
        top: 92,
        left: 175,
        child: Image.asset('assets/letters/F.png'),
      ),
      Positioned(
        top: 93,
        left: 200,
        child: Image.asset('assets/letters/G.png'),
      ),
      Positioned(
        top: 97,
        left: 225,
        child: Image.asset('assets/letters/K.png'),
      ),
      Positioned(
        top: 105,
        left: 250,
        child: Image.asset('assets/letters/L.png'),
      ),
      Positioned(
        top: 115,
        left: 270,
        child: Image.asset('assets/letters/M.png'),
      ),

      // Second arc: N to Z
      Positioned(
        top: 180,
        left: 35,
        child: Image.asset('assets/letters/N.png'),
      ),
      Positioned(
        top: 165,
        left: 55,
        child: Image.asset('assets/letters/o.png'),
      ),
      Positioned(
        top: 153,
        left: 73,
        child: Image.asset('assets/letters/p.png'),
      ),
      Positioned(
        top: 143,
        left: 93,
        child: Image.asset('assets/letters/q.png'),
      ),
      Positioned(
        top: 136,
        left: 115,
        child: Image.asset('assets/letters/r.png'),
      ),
      Positioned(
        top: 130,
        left: 140,
        child: Image.asset('assets/letters/s.png'),
      ),
      Positioned(
        top: 130,
        left: 160,
        child: Image.asset('assets/letters/t.png'),
      ),
      Positioned(
        top: 130,
        left: 185,
        child: Image.asset('assets/letters/u.png'),
      ),
      Positioned(
        top: 133,
        left: 210,
        child: Image.asset('assets/letters/v.png'),
      ),
      Positioned(
        top: 140,
        left: 235,
        child: Image.asset('assets/letters/w.png'),
      ),
      Positioned(
        top: 148,
        left: 258,
        child: Image.asset('assets/letters/x.png'),
      ),
      Positioned(
        top: 158,
        left: 280,
        child: Image.asset(
          'assets/letters/y.png',
        ),
      ),
      Positioned(
        top: 170,
        left: 295,
        child: Image.asset('assets/letters/z.png'),
      ),
    ];
  }
}
