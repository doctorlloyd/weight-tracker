import 'package:flutter/material.dart';
import 'package:mobile/utils/paint.dart';
import 'package:mobile/widget/enter_weight.dart';
import 'package:mobile/widget/list_of_weight.dart';
import 'package:mobile/widget/update_profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  var _pageOption = [WeightList(), Weight(), WeightUpdate()];

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _pageOption[currentIndex],
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        backgroundColor: currentIndex == 1
                            ? Colors.greenAccent
                            : Colors.deepOrangeAccent[100],
                        child: Icon(Icons.add,color:Colors.blueGrey.shade200,size: 35,),
                        elevation: 0.1,
                        onPressed: () {
                          setBottomBarIndex(1);
                        }),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            size: 35,
                            color: currentIndex == 0
                                ? Colors.greenAccent
                                : Colors.white70,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.accessibility,
                            size: 35,
                            color: currentIndex == 2
                                ? Colors.greenAccent
                                : Colors.white70,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}