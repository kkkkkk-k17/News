import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:three_pam/news.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        Provider(
          create: (context) => dataList,
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      )));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class News {
  String cover;
  String title;

  News({required this.cover, required this.title});
}

List dataList = [];

class _MyHomePageState extends State<MyHomePage> {
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/news.json');
    final data = await json.decode(response);
    setState(() {
      dataList = [data["featured"], data["news"]];
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    readJson();
  }

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
                    MaterialPageRoute(
                        builder: (context) => const SecondRoute()),
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
