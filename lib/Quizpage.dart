import 'package:flutter/material.dart';
import 'package:flutter_application_11/QuizResultPage.dart';
import 'dart:async';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "O que é Flutter?",
      "answers": [
        "Uma linguagem de programação",
        "Um framework para desenvolvimento de apps",
        "Uma IDE",
        "Uma biblioteca de widgets para iOS"
      ],
      "correct": 1,
      "image": "assets/midia/q1.gif",
    },
    {
      "question": "Qual linguagem de programação o Flutter utiliza?",
      "answers": ["Java", "Kotlin", "Dart", "C++"],
      "correct": 2,
      "image": "assets/midia/q2.png",
    },
    {
      "question": "Qual widget é usado para estruturar layouts no Flutter?",
      "answers": ["Container", "Scaffold", "Column", "Row"],
      "correct": 1,
      "image": "assets/midia/q3.png",
    },
    {
      "question": "Qual empresa criou o Flutter?",
      "answers": ["Apple", "Google", "Microsoft", "Facebook"],
      "correct": 1,
      "image": "assets/midia/q4.png",
    },
    {
      "question":
          "Qual é o arquivo de entrada principal em um projeto Flutter?",
      "answers": ["main.dart", "app.dart", "index.dart", "start.dart"],
      "correct": 0,
      "image": "assets/midia/q5.png"
    },
    {
      "question":
          "Qual é a função principal usada para inicializar um app Flutter?",
      "answers": ["startApp()", "runApp()", "initializeApp()", "launchApp()"],
      "correct": 1,
      "image": "assets/midia/q6.png"
    },
    {
      "question": "O que é um 'Widget' no Flutter?",
      "answers": [
        "Um componente visual",
        "Uma função de configuração",
        "Uma biblioteca externa",
        "Um tipo de variável"
      ],
      "correct": 0,
      "image": "assets/midia/q3.png"
    },
    {
      "question":
          "Qual é a diferença entre 'StatelessWidget' e 'StatefulWidget'?",
      "answers": [
        "StatelessWidget pode ser atualizado durante a execução.",
        "StatefulWidget é imutável.",
        "StatelessWidget não armazena estado.",
        "Ambos são idênticos."
      ],
      "correct": 2,
      "image": "assets/midia/q8.png"
    },
    {
      "question":
          "Qual é o comando para executar um projeto Flutter no emulador?",
      "answers": [
        "flutter run",
        "flutter start",
        "flutter execute",
        "flutter emulate"
      ],
      "correct": 0,
      "image": "assets/midia/q2.png"
    },
    {
      "question": "O Flutter suporta o desenvolvimento de quais plataformas?",
      "answers": [
        "Somente Android",
        "Somente iOS",
        "Android, iOS, Web e Desktop",
        "Apenas Android e Web"
      ],
      "correct": 2,
      "image": "assets/midia/q1.gif"
    }
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int remainingTime = 10;
  Timer? timer;

  List<String> userAnswers = [];

  void startTimer() {
    remainingTime = 10;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0 && currentQuestionIndex < questions.length) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        nextQuestion();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      startTimer();
    } else {
      timer?.cancel();
      navigateToResultPage();
    }
  }

  void handleAnswer(int index) {
    String userAnswer = questions[currentQuestionIndex]["answers"][index];
    userAnswers.add(userAnswer);

    if (index == questions[currentQuestionIndex]["correct"]) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      timer?.cancel();
      nextQuestion();
    } else {
      timer?.cancel();
      navigateToResultPage();
    }
  }

  void navigateToResultPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultPage(
          score: score,
          questions: questions,
          userAnswers: userAnswers,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final List<Color> colors = [
      Colors.blue.withOpacity(0.6),
      Colors.red.withOpacity(0.6),
      Colors.yellow.withOpacity(0.6),
      Colors.green.withOpacity(0.6),
    ];

    Color timerColor = remainingTime <= 3
        ? Colors.red
        : (remainingTime <= 7 ? Colors.orange : Colors.green);

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Pergunta ${currentQuestionIndex + 1} de ${questions.length}"),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: timerColor,
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: Text(
                "$remainingTime",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                question["question"],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: question['image'] != null && question['image'] != ''
                  ? Image.asset(
                      question['image']!,
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Center(
                          child: Text(
                            'Imagem não disponível',
                            style: TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'Imagem não disponível',
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${index + 1}. ${question["answers"][index]}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => handleAnswer(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors[0],
                        minimumSize: const Size(130, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => handleAnswer(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors[1],
                        minimumSize: const Size(130, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => handleAnswer(2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors[2],
                        minimumSize: const Size(130, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => handleAnswer(3),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors[3],
                        minimumSize: const Size(130, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
