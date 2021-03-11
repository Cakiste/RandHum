import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const List<String> Head = [
  "Afro",
  "Caesar",
  "Chongo",
  "Curly",
  "Hijab 1",
  "Long",
  "No Hair",
  "Pony",
  "Rad",
  "Short 1",
  "Short 2",
  "Short Beard",
  "Top",
  "Turban 1",
  "Turban2",
  "Wavy"
];
const List<String> Bottom = [
  "Baggy Pants",
  "Jogging",
  "Shorts",
  "Skinny Jeans Walk",
  "Skinny Jeans",
  "Skirt",
  "Sprint",
  "Sweatpants"
];
const List<String> BottomSit = [
  "Baggy Pants",
  "Skinny Jeans 1",
  "Sweat Pants",
  "Wheelchair"
];
const List<String> Body = [
  "Hoodie",
  "Jacket 2",
  "Jacket",
  "Lab Coat",
  "Long Sleeve",
  "Pointing Forward",
  "Pregnant",
  "Trench Coat",
  "Turtle Neck"
];
const List<String> Scene = ["Home", "Plants", "Whiteboard", "Wireframe"];

//ici j'ai fait le choix de harcode les noms de fichiers parce qu'il n'y en avait pas beaucoup et que je n'ai pas trouvé instantanèment comment les récupérer automatiquement

Random r = Random();

int head = r.nextInt(Head.length);
int body = r.nextInt(Body.length);
int bottom = r.nextInt(Bottom.length);
int bottomsit = r.nextInt(BottomSit.length);
int scene = r.nextInt(Scene.length);
bool stand = r.nextBool();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RandHum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'RandHum'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _randomize() {
    head = r.nextInt(Head.length);
    body = r.nextInt(Body.length);
    bottom = r.nextInt(Bottom.length);
    bottomsit = r.nextInt(BottomSit.length);
    scene = r.nextInt(Scene.length);
    stand = r.nextBool();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String sbot;
    if (stand) {
      sbot = "Standing/" + Bottom[bottom];
    } else {
      sbot = "Sitting/" + BottomSit[bottomsit];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(fit: StackFit.expand, children: [
        //j'utilise un stack car je veux superposer des images, pour l'humain il faut le corps au dessus des jambes et de la tête par exemple
        //sans le stackfit le stack avait la hauteur du premier enfant et les jambes étaient donc coupés
        Column(children: <Widget>[
          Container(
            color: Color.fromARGB(185, 255, 195, 0),
            width: width,
            height: height / 2,
          ),
          Container(
            color: Color.fromARGB(126, 112, 193, 234),
            width: width,
            height: height / 2 - 80,
          )
        ]),
        Positioned(
            top: 0,
            width: width,
            child: Image.asset('assets/Scene/' + Scene[scene] + '.png')),
        Positioned(
            left: 94,
            top: 43,
            child: Image.asset('assets/Head/Front/' + Head[head] + '.png')),
        Positioned(
            left: 13,
            top: 243,
            child: Image.asset('assets/Bottom/' + sbot + '.png')),
        Positioned(
            left: 32,
            top: 135,
            child: Image.asset('assets/Body/' + Body[body] + '.png')),
        Positioned(
            bottom: 60,
            left: 10,
            child: Column(children: <Widget>[
              Text(
                'Everytime you hit the button, a new random human will appear!',
                textAlign: TextAlign.center,
              ),
              Text(
                '(1536 possibilities)',
                textAlign: TextAlign.center,
              ),
            ]))
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: _randomize,
          tooltip: 'Randomize',
          child: Icon(Icons.shuffle)),
    );
  }
}
