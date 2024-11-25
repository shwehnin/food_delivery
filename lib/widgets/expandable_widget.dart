import 'small_text.dart';
import '../utils/color.dart';
import '../utils/dimensions.dart';
import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final String text;

  const ExpandableWidget({super.key, required this.text});

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  final double textLimit = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textLimit) {
      firstHalf = widget.text.substring(0, textLimit.toInt());
      secondHalf =
          widget.text.substring(textLimit.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimensions.font16,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hiddenText ? "$firstHalf..." : (firstHalf + secondHalf),
                  style: TextStyle(
                      fontSize: 16, height: 1.8, color: Colors.grey[800]),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: "Show more",
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
