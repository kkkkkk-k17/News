import 'package:flutter/material.dart';
import 'package:three_pam/news.dart';
// import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset('assets/images/img.png')),
            Container(
              margin: const EdgeInsets.only(top: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondRoute()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // <-- Radius
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(0, 0, 0, 1)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(130, 12, 130, 12)),
                ),
                child: const Text('Start'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
