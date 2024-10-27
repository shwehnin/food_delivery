import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String img;
  const NoDataPage(
      {super.key, required this.text, this.img = "assets/images/piza.jpg"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          img,
          height: MediaQuery.of(context).size.height * .22,
          width: MediaQuery.of(context).size.width * .22,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .03,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * .0175,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
