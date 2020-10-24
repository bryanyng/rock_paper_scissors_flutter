import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(RPSApp());
}

class RPSApp extends StatefulWidget {
  @override
  _RPSAppState createState() => _RPSAppState();
}

class _RPSAppState extends State<RPSApp> {
  int _win;

  bool _rockActive = false; // 0
  bool _paperActive = false; // 1
  bool _scissorsActive = false; // 2

  Random rng = new Random();
  int _opponent;

  void _toggleActive(int id) {
    setState(() {
      if (id == 0) {
        _rockActive = true;
        _paperActive = false;
        _scissorsActive = false;
      } else if (id == 1) {
        _rockActive = false;
        _paperActive = true;
        _scissorsActive = false;
      } else if (id == 2) {
        _rockActive = false;
        _paperActive = false;
        _scissorsActive = true;
      }
    });
  }

  void _play() {
    setState(() {
      _opponent = rng.nextInt(3);
      if (_rockActive) {
        if (_opponent == 0) {
          _win = 2;
        } else if (_opponent == 1) {
          _win = 0;
        } else if (_opponent == 2) {
          _win = 1;
        }
      } else if (_paperActive) {
        if (_opponent == 0) {
          _win = 1;
        } else if (_opponent == 1) {
          _win = 2;
        } else if (_opponent == 2) {
          _win = 0;
        }
      } else if (_scissorsActive) {
        if (_opponent == 0) {
          _win = 0;
        } else if (_opponent == 1) {
          _win = 1;
        } else if (_opponent == 2) {
          _win = 2;
        }
      }
    });
  }

  Widget outcome() {
    String outcome;
    TextStyle style;
    if (_win == 1) {
      outcome = 'You Win!';
      style = TextStyle(fontSize: 20, color: Colors.green);
    } else if (_win == 0) {
      outcome = 'You Lose!';
      style = TextStyle(fontSize: 20, color: Colors.red);
    } else if (_win == 2) {
      outcome = 'Tie';
      style = TextStyle(fontSize: 20, color: Colors.yellow);
    } else {
      outcome = '';
    }
    return Text(outcome, style: style);
  }

  Widget playerInput() {
    var rockBtn = Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: _rockActive ? Colors.green : Colors.transparent,
              width: 3)),
      child: GestureDetector(
          child: Image(
            image: AssetImage('assets/Rock.png'),
            width: 100,
          ),
          onTap: () {
            _toggleActive(0);
          }),
    );

    var paperBtn = Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: _paperActive ? Colors.green : Colors.transparent,
              width: 3)),
      child: GestureDetector(
          child: Image(
            image: AssetImage('assets/Paper.png'),
            width: 100,
          ),
          onTap: () {
            _toggleActive(1);
          }),
    );

    var scissorsBtn = Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: _scissorsActive ? Colors.green : Colors.transparent,
              width: 3)),
      child: GestureDetector(
          child: Image(
            image: AssetImage('assets/Scissors.png'),
            width: 100,
          ),
          onTap: () {
            _toggleActive(2);
          }),
    );

    return Center(
        child: Row(
      children: [rockBtn, paperBtn, scissorsBtn],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ));
  }

  Widget opponentInput() {
    Image i;
    if (_opponent == 0) {
      i = Image(
        image: AssetImage('assets/Rock.png'),
        width: 100,
      );
    } else if (_opponent == 1) {
      i = Image(
        image: AssetImage('assets/Paper.png'),
        width: 100,
      );
    } else if (_opponent == 2) {
      i = Image(
        image: AssetImage('assets/Scissors.png'),
        width: 100,
      );
    }
    return Column(children: [
      Text('Opponents Choice is:'),
      Container(
          decoration: BoxDecoration(border: Border.all(width: 3)),
          child: SizedBox(
            height: 150,
            width: 150,
            child: Center(
              child: i,
            ),
          )),
    ]);
  }

  Widget playBtn() {
    return RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        padding: EdgeInsets.all(8),
        onPressed: () {
          _play();
        },
        child: Text('Play!'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rock Paper Scissors',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text('Rock Paper Scissors Game')),
          body: Column(
            children: [
              opponentInput(),
              SizedBox(height: 20),
              outcome(),
              SizedBox(height: 20),
              playerInput(),
              SizedBox(height: 20),
              playBtn(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ));
  }
}
