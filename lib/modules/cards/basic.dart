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

  bool basic = false;
  bool showingResult = false;

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

  final List<String> _items = [
    'assets/images/cardblueleft.png',
    'assets/images/cardredright.png',
  ];

  @override
  Widget build(BuildContext context) {
    if (!basic) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _countdown > 0
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
                  child: SizedBox(
                    width: double.infinity,
                    height: 280,
                    child: Stack(
                      children: _items.asMap().entries.map(
                        (entry) {
                          int index = entry.key;
                          String imagePath = entry.value;
                          return Positioned(
                            key: ValueKey(imagePath),
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  basic = true;
                                });
                              },
                              child: Draggable<String>(
                                data: imagePath,
                                feedback: _buildImage(index, isDragging: true),
                                child: _buildImage(index),
                                onDragCompleted: () {
                                  setState(() {
                                    final item = _items.removeAt(index);
                                    _items.insert(0, item);
                                  });
                                },
                                onDragEnd: (details) {
                                  if (details.offset.dx > 100) {
                                    setState(() {
                                      final item = _items.removeAt(index);
                                      _items.insert(0, item);
                                    });
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
        ],
      );
    } else {
      final image = images[Random().nextInt(2)];
      if (image == 'yes') {
        context.read<CardCubit>().updateCount(true);
      } else {
        context.read<CardCubit>().updateCount(false);
      }
      setState(() {
        showingResult = true;
        _startResetCountdown();
      });
      return Center(child: Image.asset('assets/images/$image.png'));
    }
  }

  List<String> images = ['yes', 'no'];

  Widget _buildImage(int index, {bool isDragging = false}) {
    return Opacity(
      opacity: isDragging ? 0.3 : 1.0,
      child: Image.asset(_items[index], fit: BoxFit.contain),
    );
  }
}
