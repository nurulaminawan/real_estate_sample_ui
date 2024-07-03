import 'package:flutter/material.dart';

class SlideUpText extends StatefulWidget {
  final String text;

  SlideUpText({required this.text});

  @override
  _SlideUpTextState createState() => _SlideUpTextState();
}

class _SlideUpTextState extends State<SlideUpText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Text(
        widget.text,
        style:
            TextStyle(fontSize: 34.0, color: Color.fromARGB(255, 123, 104, 46)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
