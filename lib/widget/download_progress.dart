import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainPage()));
            },
            icon: Icon(Icons.home_outlined),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width,
            animation: true,
            lineHeight: 25.0,
            animationDuration: 900,
            percent: 1,
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.pink,
          ),
        )
      ),
    );
  }
}

