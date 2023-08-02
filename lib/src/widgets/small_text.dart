import 'package:flutter/material.dart';
//purpose of this is to reuse the font and text color


class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  String? fontWeight;
  final VoidCallback? onTap;


  SmallText({Key? key, this.color =const Color(0xFFccc7c5),
    required this.text,
    this.size=12,
    this.height =1.2,
    this.fontWeight,this.onTap,

  }): super(key:key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: color,
        ),
      ),
    );
  }

}
