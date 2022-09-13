import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  FirstW() {
    return Text(
      '👮',
      style: TextStyle(fontSize: cellWidth * .8),
    );
  }

  secondW() {
    return Text(
      '🚓',
      style: TextStyle(fontSize: cellWidth * .8),
    );
  }

  int L = 7;
  int W = 7;
  late double cellWidth;
  late int wpos, lpos, swpos, slpos;
  late double firstPosW;
  late double firstPosL;
  late double secondPosW;
  late double secondPosL;

  @override
  void initState() {
    super.initState();
  }

  generate() {
    W = int.tryParse(_controller1.text.toString()) ?? 7;
    L = int.tryParse(_controller2.text.toString()) ?? 7;
    getPositions();

    Size size = MediaQuery.of(context).size;
    cellWidth = size.width / W;
    if (cellWidth * L > size.height - 200) {
      cellWidth = (size.height - 200) / L;
    }

    firstPosW = cellWidth * wpos;
    firstPosL = cellWidth * lpos;
    secondPosW = cellWidth * swpos;
    secondPosL = cellWidth * slpos;
  }

  getPositions() async {
    wpos = Random().nextInt(W);
    lpos = Random().nextInt(L);

    swpos = Random().nextInt(W);
    slpos = Random().nextInt(L);

    if (wpos == swpos) {
      if (swpos + 1 == W) {
        swpos -= 1;
      } else {
        swpos += 1;
      }
    }

    if (lpos == slpos) {
      if (slpos + 1 == L) {
        slpos -= 1;
      } else {
        slpos += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    generate();
    return Scaffold(
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(hintText: 'Width'),
                        controller: _controller1,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: 'Height'),
                        controller: _controller2,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text('Generate Grid'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(left: firstPosW, top: firstPosL, child: FirstW()),
                Positioned(left: secondPosW, top: secondPosL, child: secondW()),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Change Position')),
            ),
          ),
        ],
      ),
    );
  }
}
