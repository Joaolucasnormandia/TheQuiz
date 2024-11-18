import 'package:flutter/material.dart';
import 'package:flutter_application_11/Quizrule.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '<the\n',
                    style: GoogleFonts.arimo(
                      fontSize: 66,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(209, 196, 233, 1),
                    ),
                  ),
                  TextSpan(
                    text: 'quiz>',
                    style: GoogleFonts.arimo(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 250),
            Align(
              alignment: Alignment.center,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 1.0, end: 1.3),
                duration: const Duration(seconds: 100),
                curve: Curves.easeInOut,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizRule()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor:
                            const Color.fromARGB(209, 220, 180, 228),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  );
                },
                onEnd: () {
                  // Reinicia o widget para loop contínuo
                  Future.microtask(() => (context as Element).markNeedsBuild());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
