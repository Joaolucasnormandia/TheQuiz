import 'package:flutter/material.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:flutter_application_11/Quizpage.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizRule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regras do Quiz'),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'REGRAS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '- Proíbido consulta externas\n- Cada pergunta tem um tempo limite',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'arimo',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/midia/ruleimage.gif',
                width: 350,
                height: 350,
              ),
            ),
            SizedBox(height: 60),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 255, 202, 251)),
                  fixedSize: MaterialStateProperty.all(Size(250, 70)),
                ),
                child: Text(
                  'COMEÇAR',
                  style: GoogleFonts.arimo(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(20, 20, 20, 1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
