import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;
  // Determine whether the container moving or not
  bool movementCompleted = true;
  // Determine Container Location
  late Alignment alignment;
  @override
  void initState() {
    // start with Container in the center
    alignment = Alignment.center;
    super.initState();
  }

  /// Move Container to new Position by Changing direction
  /// The [direction] determine the direction which container moves to
  ///
  /// This function sets [movementCompleted] to `false` while animation in progress
  ///  and resets it to `true` after 1 second
  void moveContainer({required Alignment direction}) {
    setState(() {
      alignment = direction;
      movementCompleted = false;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        movementCompleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.ease,
          alignment: alignment,
          child: Container(
            width: _squareSize,
            height: _squareSize,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              // move to right only if not already there or movement completed
              onPressed: (movementCompleted == false) ||
                      (alignment == Alignment.topRight)
                  ? null
                  : () {
                      moveContainer(direction: Alignment.topRight);
                    },
              child: const Text('Right'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              // moves to left only if not already there or movement completed
              onPressed: (movementCompleted == false) ||
                      (alignment == Alignment.topLeft)
                  ? null
                  : () {
                      moveContainer(direction: Alignment.topLeft);
                    },
              child: const Text('Left'),
            ),
          ],
        ),
      ],
    );
  }
}
