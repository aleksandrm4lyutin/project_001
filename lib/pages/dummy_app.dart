import 'package:flutter/material.dart';

class DummyApp extends StatefulWidget {
  const DummyApp({Key? key}) : super(key: key);

  @override
  State<DummyApp> createState() => _DummyAppState();
}

class _DummyAppState extends State<DummyApp> {

  ///
  double bottom = 550;
  double top = 50;
  double speed = 0.75;
  double zoneHeight = 150;
  double ballSize = 80;
  bool play = false;
  int currentScore = 0;
  int maxScore = 0;
  late int time;
  late double start;
  late double end;
  late double left;
  late double width;
  late double position;
  late bool up;
  late double zoneStart;
  late double zoneEnd;


  void setInitialCoordinates() {
    start = bottom;
    end = bottom;
    left = 0;
    position = start;
    calculateTime();
    up = false;
    play = false;
  }

  void calculateCoordinates(double w, double h) {
    width = w;
    left = (w * 0.5) - (ballSize * 0.5);
    zoneStart = (h * 0.5);
    zoneEnd = zoneStart + zoneHeight;
  }

  void kick() {
    up = true;
    setState(() {
      start = position;
      end = top;
      calculateTime();
    });
  }

  void drop() {
    up = false;
    setState(() {
      start = position;
      end = bottom;
      calculateTime();
    });
  }

  void calculateTime() {
    time = ((start - end).abs())~/speed;
  }

  void checkBallPosition() {
    if(!up) {

    } else {

    }

    if(!up && position > zoneEnd) {
      play = false;
      if(currentScore > maxScore) {
        maxScore = currentScore;
      }
      currentScore = 0;
    } else {
      play = true;
    }
  }


  @override
  void initState() {
    super.initState();

    setInitialCoordinates();
  }

  @override
  Widget build(BuildContext context) {


    var mcs = MediaQuery.of(context).size;
    calculateCoordinates(mcs.width, mcs.height);
    checkBallPosition();

    return Scaffold(
      backgroundColor: Colors.green.shade700,

      body: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: start, end: end),
          duration: Duration(milliseconds: time),
          curve: up ? Curves.decelerate : Curves.easeInOut,
          onEnd: () {
            drop();
          },
          builder: (BuildContext context, double pos, Widget? child) {
            position = pos;

            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10,),
                        Column(
                          children: [
                            const Text('MAX SCORE:', style: TextStyle(fontSize: 18, color: Colors.white),),
                            Text('$maxScore', style: const TextStyle(fontSize: 18, color: Colors.white),),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('SCORE:', style: TextStyle(fontSize: 18, color: Colors.white),),
                            Text('$currentScore', style: const TextStyle(fontSize: 18, color: Colors.white),),
                          ],
                        ),
                        const SizedBox(width: 10,),
                      ],
                    )
                  ],
                ),

                Positioned(
                  top: position,
                  left: left,
                  child: child!,
                ),
                Positioned(
                  top: zoneStart,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      //HapticFeedback.vibrate();
                      if(!play) {
                        kick();
                      }
                      if(position > zoneStart && position < zoneEnd) {
                        kick();
                        currentScore += 100;
                      }
                    },
                    child: Container(
                      width: width,
                      height: zoneHeight,
                      color: Colors.black45,
                      alignment: Alignment.center,
                      child: const Text(
                        'Tap to kick the ball while it is in that zone',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ),
                  ),
                ),

                !play ? Container(
                  color: Colors.black45,
                ) : const SizedBox(height: 0,),
                !play ? Positioned(
                  top: zoneStart + 25,
                  left: 30,
                  child: Container(
                    width: width - 60,
                    height: 100,
                    color: Colors.red.shade900,
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const Text('Start', style: TextStyle(fontSize: 30, color: Colors.white),),
                      onPressed: () {
                        setState(() {
                          play = true;
                        });
                        kick();
                      },
                    ),
                  ),
                ) : const SizedBox(height: 0,),
              ],
            );
          },
          child: Image(
            image: const AssetImage('assets/playstore.png'),
            height: ballSize,
            width: ballSize,
          ),
        ),
      ),
    );
  }
}
