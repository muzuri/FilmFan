import 'package:badges/badges.dart';
import 'package:filmfan/utils/colors.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = appDarkOverlayColor,
    this.iconColor = whiteColor,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor),
      child: Stack(
        children: [
          Positioned(
            bottom: 7,
            top: 7,
            left: 4,
            right: 4,
            child: Icon(
              icon,
              color: iconColor,
              size: size / 2,
            ),
          ),

        ],
      ),
    );
  }
}