import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmoney_lite/widgets/show_alert.dart';

import '../utility/style.dart';

class buildCircleIcon extends StatelessWidget {
  const buildCircleIcon({
    super.key,
    required this.title,
    required this.svgPicture,
    required this.rounteName,
  });
  final String title;
  final String rounteName;
  final String svgPicture;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.0),
            color: Colors.white.withOpacity(0),
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(1000.0),
            onTap: () {
              if (rounteName != '/') {
                Navigator.pushNamed(context, rounteName);
              } else {
                showFailedAlert(
                  context,
                  'Error',
                  'Not available',
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 40,
                width: 40,
                child: SvgPicture.asset(svgPicture),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: Style.textLaoStyle,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
        ),
      ],
    );
  }
}
