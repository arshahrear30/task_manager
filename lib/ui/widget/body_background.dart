import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BodyBackground extends StatelessWidget {
  const BodyBackground({super.key, required this.child});//required koira dici widget er bitor

  final Widget child;//final মানে = একবার set, lifetime জুড়ে constant

  @override
  Widget build(BuildContext context) {

        return Stack( // Stack = একটার ওপর আরেকটা widget বসানোর টুল UI design এ খুব powerful
          children: [
            SvgPicture.asset(
              "assets/images/bgs.svg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            child, //required child bolci tai eikhane o child dite hoibo ..
          ],

    );
  }
}
