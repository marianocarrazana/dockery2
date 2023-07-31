import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.color,
      this.margin = const EdgeInsets.all(2.0),
      this.padding = const EdgeInsets.all(2.0)});
  final IconData icon;
  final void Function()? onPressed;
  final Color? color;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? Theme.of(context).colorScheme.outline;
    return Padding(
      padding: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide?>(
            (Set<MaterialState> states) {
              HSLColor outlineColor = HSLColor.fromColor(themeColor);
              if (states.contains(MaterialState.pressed)) {
                outlineColor = outlineColor.withLightness(.3);
              } else if (states.contains(MaterialState.hovered)) {
                outlineColor = outlineColor.withLightness(.8);
              }
              return BorderSide(color: outlineColor.toColor(), width: 1.5);
            },
          ),
        ),
        child: Padding(
          padding: padding,
          child: Icon(
            icon,
            color: themeColor,
          ),
        ),
      ),
    );
  }
}
