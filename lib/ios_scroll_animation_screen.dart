import 'package:flutter/material.dart';
import 'package:render_object_demo/get_btn_row.dart';
import 'package:render_object_demo/utils.dart';

class IosScrollAnimationScreen extends StatefulWidget {
  const IosScrollAnimationScreen({Key? key}) : super(key: key);

  @override
  _IosScrollAnimationScreenState createState() =>
      _IosScrollAnimationScreenState();
}

class _IosScrollAnimationScreenState extends State<IosScrollAnimationScreen> {
  late ScrollController _controller;

  final GlobalKey _globalKey1 = GlobalKey();
  final GlobalKey _globalKey2 = GlobalKey();

  bool _isCrossed = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        _calculate();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _globalKey1,
        title: const Text('Back'),
        centerTitle: false,
        backgroundColor: const Color(0xff1c1c1e),
        elevation: 0,
        actions: [
          Switcher(
            child: _isCrossed
                ? GetBtnRow(
                    showShareIcon: !_isCrossed,
                    isGetBtnAhead: _isCrossed,
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
      backgroundColor: const Color(0xff1c1c1e),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Placeholder(
                    fallbackHeight: 110,
                    fallbackWidth: 110,
                    color: Colors.blueGrey,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Awesome app \n',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: 'Awesome app ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        key: _globalKey2,
                        child: Switcher(
                          child: !_isCrossed
                              ? const GetBtnRow()
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2,
            )
          ],
        ),
      ),
    );
  }

  void _calculate() {
    if (_globalKey1.globalPaintBounds != null &&
        _globalKey2.globalPaintBounds != null &&
        _globalKey2.globalPaintBounds!.topCenter.dy <
            _globalKey1.globalPaintBounds!.topCenter.dy +
                _globalKey1.globalPaintBounds!.height) {
      _isCrossed = true;
    } else {
      _isCrossed = false;
    }
    setState(() {});
  }
}
