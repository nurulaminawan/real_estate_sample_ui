import 'package:flutter/material.dart';

class IncrementCounter extends StatefulWidget {
  final int startValue, endValue;
  final bool whitecolor;

  const IncrementCounter({
    Key? key,
    required this.startValue,
    required this.endValue,
    required this.whitecolor,
  }) : super(key: key);

  @override
  _IncrementCounterState createState() => _IncrementCounterState();
}

class _IncrementCounterState extends State<IncrementCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = IntTween(begin: widget.startValue, end: widget.endValue)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _animation.value.toString(),
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color: widget.whitecolor
            ? Colors.white
            : Color.fromARGB(255, 194, 136, 115),
      ),
    );
  }
}
