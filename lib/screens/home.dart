import 'package:flutter/material.dart';
import 'package:real_estate_app/components/increment_counter.dart';
import 'package:real_estate_app/components/slide_text.dart';
import 'package:real_estate_app/components/sliding_animation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _opacityAnimation;
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;
  double largeGridWidth = 40.0;
  double smallGridWidth = 40.0;
  bool animate = false;

  void _animateButton() {
    setState(() {
      animate = !animate;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: 0.0,
      end: 250.0, // Adjust to your desired final width
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    _controller.forward();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        largeGridWidth = MediaQuery.of(context).size.width - 30;
        smallGridWidth = MediaQuery.of(context).size.width / 2 - 20;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Real Estate App'),
      // ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              AnimatedOpacity(
                opacity: (_scrollOffset < 100) ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: topInfoBar(),
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: (_scrollOffset < 100) ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: textWelcomeNote(),
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: (_scrollOffset < 100) ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buyCircle(),
                    SizedBox(
                      width: 10,
                    ),
                    rentRectangle()
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255), width: 2),
                ),
                width: MediaQuery.of(context).size.width - 10,
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      // alignment: Alignment.centerLeft,
                      bottom: 20, left: 1,
                      child: slidingAnimation(largeGridWidth),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Color.fromARGB(255, 255, 255, 255), width: 4),
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                          // alignment: Alignment.centerLeft,
                          bottom: 20, left: 1,
                          child: slidingAnimation(smallGridWidth),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Color.fromARGB(255, 255, 255, 255), width: 4),
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                          // alignment: Alignment.centerLeft,
                          bottom: 20, left: 1,
                          child: slidingAnimation(smallGridWidth),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Color.fromARGB(255, 255, 255, 255), width: 4),
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                          // alignment: Alignment.centerLeft,
                          bottom: 20, left: 1,
                          child: slidingAnimation(smallGridWidth),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Color.fromARGB(255, 255, 255, 255), width: 4),
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                          // alignment: Alignment.centerLeft,
                          bottom: 20, left: 1,
                          child: slidingAnimation(smallGridWidth),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topInfoBar() {
    return Row(
      children: [
        AnimatedBuilder(
          animation: _widthAnimation,
          builder: (context, child) {
            return Container(
              width: _widthAnimation.value,
              height: 70,
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimatedBuilder(
                    animation: _opacityAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityAnimation.value,
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.location_on,
                                    size: 17.0,
                                    color: Color.fromARGB(255, 190, 146, 130),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Saint Petersburg',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 190, 146, 130),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 2),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/2787341/pexels-photo-2787341.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'), // Replace with your image URL
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget textWelcomeNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, Marina',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: const Color.fromARGB(255, 171, 150, 88)),
        ),
        SizedBox(height: 10),
        SlideUpText(
          text: 'let\'s Select your\nperfect place',
        ),
      ],
    );
  }

  Widget buyCircle() {
    return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: Text(
                'buy'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              child: IncrementCounter(
                startValue: 700,
                endValue: 1070,
                whitecolor: true,
              ),
            ),
            Positioned(
              bottom: 30,
              child: Text(
                'offers'.toLowerCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }

  Widget rentRectangle() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: Text(
                'Rent'.toUpperCase(),
                style: TextStyle(
                  color: Color.fromARGB(255, 194, 136, 115),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Positioned(
              child: IncrementCounter(
                startValue: 2900,
                endValue: 3070,
                whitecolor: false,
              ),
            ),
            Positioned(
              bottom: 30,
              child: Text(
                'OFFERS'.toLowerCase(),
                style: TextStyle(
                  color: Color.fromARGB(255, 194, 136, 115),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
}
