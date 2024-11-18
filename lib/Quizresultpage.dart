import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:flutter_application_11/QuizRule.dart';

class QuizResultPage extends StatelessWidget {
  final int score;
  final List<Map<String, dynamic>> questions;
  final List<String> userAnswers;

  const QuizResultPage({
    required this.score,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int totalQuestions = questions.length;
    int incorrectAnswers = totalQuestions - score;

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado do Quiz'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: score.toDouble(),
                      title: 'Acertos',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: incorrectAnswers.toDouble(),
                      title: 'Erros',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Acertos: $score",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Erros: $incorrectAnswers",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizRule()),
                );
              },
              icon: Icon(Icons.replay),
              label: const Text("Reiniciar Quiz"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
