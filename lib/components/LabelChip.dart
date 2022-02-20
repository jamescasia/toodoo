import 'package:flutter/material.dart';

import '../utils/Constants.dart';

class LabelChip extends StatelessWidget {
  LabelChip(this.text, this.selected, this.color);

  final String text;
  final bool selected;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: selected ? 1.12 : 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: selected ? 6 : 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(selected ? 0.3 : 0.0),
              blurRadius: 2.0,
              offset: Offset(0, 1))
        ], color: color, borderRadius: BorderRadius.all(Radius.circular(999))),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              selected
                  ? Container(
                      height: 12,
                      width: 12,
                      margin: EdgeInsets.only(right: 12),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(999))),
                    )
                  : SizedBox(),
              Text(
                text,
                style: const TextStyle(
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              )
            ]),
      ),
    );
  }
}
