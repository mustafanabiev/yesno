import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yesno/modules/cards/cubit/card_cubit.dart';

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  int _countdown = 5;
  Timer? _timer;
  Timer? _resetTimer;
  bool flipX = false;
  bool basic = false;
  bool showingResult = false;

  final List<String> _items = [
    'assets/images/blue.png',
    'assets/images/red.png',
  ];

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _startResetCountdown() {
    _resetTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _countdown = 5;
        basic = false;
        showingResult = false;
        flipX = false;
        _startCountdown();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !basic ? _buildCountdownView() : _buildResultView(),
    );
  }

  Widget _buildCountdownView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _countdown > 0 ? _buildCountdownWidget() : _buildCardSwappingView(),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    final image = images[Random().nextInt(images.length)];
    context.read<CardCubit>().updateCount(image == 'yes');
    showingResult = true;
    _startResetCountdown();
    return Center(child: Image.asset('assets/images/$image.png'));
  }

  List<String> images = ['yes', 'no'];

  Widget _buildCountdownWidget() {
    return Center(
      child: Column(
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
          Image.asset('assets/images/question.png', height: 276),
        ],
      ),
    );
  }

  Widget _buildCardSwappingView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 280,
          child: Stack(
            children: List.generate(_items.length, (index) {
              String imagePath = _items[index];
              double horizontalOffset = index == 0 ? 0 : 110;
              double verticalOffset = index == 0 ? -10 : 0;
              double rotationAngle = index == 0 ? -0.1 : 0;

              if (index == 1) {
                return Transform.translate(
                  offset: Offset(horizontalOffset, verticalOffset),
                  child: Transform.rotate(
                    angle: rotationAngle,
                    child: DragTarget<String>(
                      onAcceptWithDetails: (details) {
                        setState(() {
                          basic = true;
                        });
                      },
                      builder: (BuildContext context, List<dynamic> accepted,
                          List<dynamic> rejected) {
                        return Draggable<String>(
                          onDraggableCanceled: (velocity, offset) {
                            setState(() {
                              basic = true;
                            });
                          },
                          onDragCompleted: () {
                            setState(() {
                              basic = true;
                            });
                          },
                          onDragEnd: (details) {
                            if (!details.wasAccepted) {
                              setState(() {
                                basic = true;
                              });
                            }
                          },
                          data: imagePath,
                          feedback: Material(
                            type: MaterialType.transparency,
                            child: Image.asset(imagePath, height: 276),
                          ),
                          childWhenDragging: Container(),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                basic = true;
                              });
                            },
                            child: Image.asset(
                              imagePath,
                              key: ValueKey(imagePath),
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Transform.translate(
                  offset: Offset(horizontalOffset, verticalOffset),
                  child: Transform.rotate(
                    angle: rotationAngle,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          String temp = _items[0];
                          _items[0] = _items[1];
                          _items[1] = temp;
                          flipX = !flipX;
                        });
                      },
                      child: Image.asset(
                        imagePath,
                        key: ValueKey(imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
