import 'dart:async';

import 'package:flutter/material.dart';

class WidgetAnimation extends StatefulWidget {
  final String address;
  final int length;
  final int duration;
  const WidgetAnimation({Key? key,
    required this.address,
    required this.length,
    required this.duration
  }) : super(key: key);

  @override
  _WidgetAnimationState createState() => _WidgetAnimationState();
}

class _WidgetAnimationState extends State<WidgetAnimation> {

  int count = 1;

  setUpTimedAnimation() {
    Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
      setState(() {
        count+=1;
        if( count ==widget.length + 1){
          count = 1;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpTimedAnimation();
  }
  @override
  Widget build(BuildContext context) {
    return Image.asset("${widget.address}${count}.png");
  }
}
