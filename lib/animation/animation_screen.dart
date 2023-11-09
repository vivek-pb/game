import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late AnimationController controller3;
  late AnimationController controller4;

  late Animation<double> animation;
  Animation<double>? animation2;
  Animation<double>? animation3;
  Animation<double>? animation4;

  String image = "assets/lamps2.png";

  bool isDark = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller3 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller4 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animation = Tween<double>(begin: 0, end: 130).animate(controller);

    controller.addListener(() {
      if (controller.isCompleted) {
        //  controller.reverse();
        animation = Tween<double>(begin: 130, end: 0).animate(controller2);
        animation2 = Tween<double>(begin: 0, end: 130).animate(controller2);

        controller2.forward();
      }
      setState(() {});
    });
    controller.forward();

    controller2.addListener(() {
      if (controller2.isCompleted) {
        height2 = 130;
        //  controller.reverse();
        animation2 = Tween<double>(begin: 130, end: 0).animate(controller3);
        animation3 = Tween<double>(begin: 0, end: 130).animate(controller3);
        controller3.forward();
      }
      setState(() {});
    });

    controller3.addListener(() {
      if (controller3.isCompleted) {
        //  controller.reverse();
        animation3 = Tween<double>(begin: 130, end: 0).animate(controller4);
        animation4 = Tween<double>(begin: 130, end: 0).animate(controller4);
        controller4.forward();
      }
      setState(() {});
    });

    controller4.addListener(() {
      setState(() {});
    });
  }

  double dy = 0;

  double height2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Animation',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (animation2 != null)
                SizedBox(
                  width: animation2!.value,
                ),
              Container(
                height: 2,
                width: animation.value,
                color: Colors.white,
              ),
            ],
          ),
          if (animation2 != null)
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: !controller4.isCompleted
                          ? height2
                          : animation4!.value,
                      width: animation4 != null ? 2 : 130,
                      color: animation4 != null
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    if (animation4 != null)
                      SizedBox(
                        height: 130 - animation4!.value,
                      )
                  ],
                ),
                Column(
                  children: [
                    if (controller2.isCompleted)
                      SizedBox(
                        height: height2 - animation2!.value,
                      ),
                    Container(
                      height: animation2!.value,
                      width: 2,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          if (animation3 != null)
            Row(
              children: [
                if (!controller3.isCompleted)
                  SizedBox(
                    width: 130 - animation3!.value,
                  ),
                Container(
                  height: 2,
                  width: animation3!.value,
                  color: Colors.white,
                ),
                if (animation4 != null)
                  SizedBox(
                    width: 130 - animation4!.value,
                  )
              ],
            ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3341667, size.height * 0.3557143);
    path_0.lineTo(size.width * 0.2916667, size.height * 0.5700000);
    path_0.lineTo(size.width * 0.4591667, size.height * 0.5700000);
    path_0.lineTo(size.width * 0.4166667, size.height * 0.3571429);
    path_0.lineTo(size.width * 0.3341667, size.height * 0.3557143);
    path_0.close();

    // canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    // canvas.drawPath(path_0, paint_stroke_0);
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
