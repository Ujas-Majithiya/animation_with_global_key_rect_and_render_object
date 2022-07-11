import 'package:flutter/material.dart';
import 'package:render_object_demo/utils.dart';

class WidgetOverlapScreen extends StatefulWidget {
  const WidgetOverlapScreen({Key? key}) : super(key: key);

  @override
  _WidgetOverlapScreenState createState() => _WidgetOverlapScreenState();
}

class _WidgetOverlapScreenState extends State<WidgetOverlapScreen> {
  double _dx1 = 0;
  double _dx2 = 0;
  double _dy1 = 0;
  double _dy2 = 0;

  final GlobalKey _globalKey1 = GlobalKey();
  final GlobalKey _globalKey2 = GlobalKey();

  bool _intersects = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: _dy1,
            left: _dx1,
            child: GestureDetector(
              onPanUpdate: onPanUpdate1,
              child: Container(
                key: _globalKey1,
                height: 200,
                width: 150,
                color:  _intersects ? Colors.green : Colors.redAccent,
              ),
            ),
          ),
          Positioned(
            top: _dy2,
            left: _dx2,
            child: GestureDetector(
              onPanUpdate: onPanUpdate2,
              child: Container(
                height: 100,
                width: 50,
                key: _globalKey2,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate1(DragUpdateDetails details) {
    _dx1 = details.globalPosition.dx;
    _dy1 = details.globalPosition.dy;
    _calculateIntersection();
  }

  void onPanUpdate2(DragUpdateDetails details) {
    _dx2 = details.globalPosition.dx;
    _dy2 = details.globalPosition.dy;
    _calculateIntersection();
  }

  void _calculateIntersection() {
    if (_globalKey2.globalPaintBounds != null &&
        _globalKey1.globalPaintBounds != null &&
        _globalKey2.globalPaintBounds!
                .overlaps(_globalKey1.globalPaintBounds!)
                   ) {
      ///Or we can use
      ///_globalKey2.globalPaintBounds!
      ///.intersect(_globalKey1.globalPaintBounds!).height > 0
      ///&& _globalKey2.globalPaintBounds!
      /// .intersect(_globalKey1.globalPaintBounds!).width > 0
      _intersects = true;
    } else {
      _intersects = false;
    }
    setState(() {});
  }
}
