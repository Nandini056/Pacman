import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final Color innercolor;
  final Color outercolor;
  final Widget child;

  MyPixel({required this.innercolor, required this.outercolor,required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.all(4),
          color: outercolor,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(

              color: innercolor,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
