import 'package:flutter/material.dart';
import 'package:weather_app/src/utils/app_constants.dart';
import 'package:weather_app/src/widgets/big_text.dart';
import 'package:weather_app/src/widgets/small_text.dart';

import '../utils/dimensions.dart';



class MinCurrentMaxWidget extends StatelessWidget {
  /*
  we can also include:
  pressure, and all other additional info
  * */
  final BigText bigText;
  //final String iconImage;
  final SmallText smallText;
  const MinCurrentMaxWidget({super.key, required this.bigText,  required this.smallText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width10, top: Dimensions.height10,),
      child: Column(
        children: [
          // Image(
          //     image: AssetImage(iconImage),),
               bigText,
            smallText,

        ],

      ),
    );
  }
}
