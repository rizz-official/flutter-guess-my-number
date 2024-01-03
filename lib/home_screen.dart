import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int secretNumber = 0;
  String secretText = '?';
  int score = 20;
  int highScore = 0;
  String showMessage = 'Start Guessing...✨';
  Color backgroundColor = const Color(0xFF222222);
  final _numberController = TextEditingController();
  @override
  void initState() {
    secretNumber = Random().nextInt(30) + 1;
    print(secretNumber);
    super.initState();
  }

  void onCheck() {
    setState(() {
      if (_numberController.text.isEmpty) {
        showMessage = 'No Number Entered 😒';
      } else if (int.parse(_numberController.text) == secretNumber) {
        if (score > highScore) {
          highScore = score;
          backgroundColor = Colors.green;
          secretText = _numberController.text;
          showMessage = '🎉 Correct Number!';
        }
      } else if (int.parse(_numberController.text) != secretNumber) {
        if (score > 0) {
          showMessage = int.parse(_numberController.text) > secretNumber
              ? 'Too High 📈'
              : 'Too Low 📉';
          score--;
          score = score;
          _numberController.clear();
        } else if (score == 0) {
          showMessage = '💥 YOU LOOSE THE GAME';
          backgroundColor = Colors.red;
          secretText = secretNumber.toString();
        }
      } else {
        _numberController.clear();
        return;
      }
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Guess My Number!',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 20,
                        color: const Color(0xFFEEEEEE),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '(Between 1 and 30)',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 14,
                        color: const Color(0xFFEEEEEE),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 4,
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            secretText,
                            style: GoogleFonts.pressStart2p(
                                color: Colors.black, fontSize: 36),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 4,
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  showMessage,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: const Color(0xFFEEEEEE),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: 170,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFEEEEEE), width: 2),
                      ),
                      child: TextField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 30,
                          color: const Color(0xFFEEEEEE),
                        ),
                        cursorColor: const Color(0xFFEEEEEE),
                        maxLength: 2,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 55, bottom: 8),
                            counterText: ''),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: onCheck,
                      child: Text(
                        'Check!',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Score : $score',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 14,
                        color: const Color(0xFFEEEEEE),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Highscore : $highScore',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 14,
                        color: const Color(0xFFEEEEEE),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              secretNumber = Random().nextInt(30) + 1;
              score = 20;
              backgroundColor = const Color(0xFF222222);
              secretText = '?';
              showMessage = 'Start Guessing...✨';
              _numberController.clear();
            });
          },
          child: Text(
            'Again!',
            style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
