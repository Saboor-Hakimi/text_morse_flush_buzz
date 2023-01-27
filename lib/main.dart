import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:torch/torch.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

Map timimg = {'-': 200, '.': 50, ' ': 0};
Map mapper = {
  'a': '.-',
  'b': '-...',
  'c': '-.-.',
  'd': '-..',
  'e': '.',
  'f': '..-.',
  'g': '--.',
  'h': '....',
  'i': '..',
  'j': '.---',
  'k': '-.-',
  'l': '.-..',
  'm': '--',
  'n': '-.',
  'o': '---',
  'p': '.--.',
  'q': '--.-',
  'r': '.-.',
  's': '...',
  't': '-',
  'u': '..-',
  'v': '...-',
  'w': '.--',
  'x': '-..-',
  'y': '-.--',
  'z': '--..',
  ' ': '     '
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController texty = TextEditingController();

  String code = '';

  void encoder() {
    setState(() {
      String temp = texty.text.toLowerCase();
      code = '';
      for (int i = 0; i < temp.length; i++) {
        code += mapper[temp[i]] + ' ';
      }
    });
  }

  void vibe() {
    for (int i = 0; i < code.length - 1; i++) {
      int time = timimg[code[i]];
      Vibration.vibrate(duration: time);
      sleep(Duration(milliseconds: time + 100));
    }
  }

  void lit() {
    for (int i = 0; i < code.length - 1; i++) {
      int time = timimg[code[i]];
      time > 0 ? Torch.turnOn() : 1;
      sleep(Duration(milliseconds: time));
      Torch.turnOff();
      sleep(const Duration(milliseconds: 100));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text > Morse > Vibe > Torch'),
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: texty,
        ),
        ElevatedButton(
            onPressed: encoder,
            child: const Text(
              "Convert To Morse Code",
            )),
        Text(
          code,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: vibe,
                child: const Text(
                  "Vibration",
                )),
            ElevatedButton(
                onPressed: lit,
                child: const Text(
                  "Torch",
                ))
          ],
        )
      ]),
    );
  }
}
