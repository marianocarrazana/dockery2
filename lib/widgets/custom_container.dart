import 'package:flutter/material.dart';
import 'package:hsluv/hsluvcolor.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.radius = 4.0,
    this.margin = 8.0,
    this.padding = 8.0,
    this.opacity = 0.12,
    this.borderColor,
    this.borderWidth = 1.5,
    this.cursor = MouseCursor.defer,
    this.hoverEffect = false,
    this.onTap,
    this.width,
    this.height,
  });
  final Widget child;
  final double radius;
  final double margin;
  final double padding;
  final double opacity;
  final Color? borderColor;
  final double borderWidth;
  final MouseCursor cursor;
  final bool hoverEffect;
  final void Function()? onTap;
  final double? width;
  final double? height;
  @override
  State<CustomContainer> createState() => _SatoriContainer();
}

class _SatoriContainer extends State<CustomContainer> {
  bool _isHover = false;

  void updateIsHover(newState) {
    setState(() {
      _isHover = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double hue = 0;
    Color background = theme.colorScheme.background;
    Color backgroundHover =
        HSLuvColor.fromColor(background).withLightness(25).toColor();
    const BoxShadow shadow = BoxShadow(
        color: Colors.black,
        offset: Offset(0.0, 6.0),
        spreadRadius: -6,
        blurRadius: 6);
    BoxShadow shadowHover = BoxShadow(
        color: HSLColor.fromAHSL(1, hue, 0.85, 0.65).toColor(), blurRadius: 6);
    return MouseRegion(
        cursor: widget.cursor,
        onEnter: widget.hoverEffect ? (event) => updateIsHover(true) : null,
        onExit: widget.hoverEffect ? (event) => updateIsHover(false) : null,
        child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: widget.width,
              height: widget.height,
              margin: EdgeInsets.all(widget.margin),
              child: AnimatedContainer(
                padding: EdgeInsets.all(widget.padding),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: widget.borderWidth,
                      color: widget.borderColor ??
                          const Color.fromARGB(100, 255, 255, 255)),
                  color: _isHover ? backgroundHover : background,
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius)),
                  boxShadow: [_isHover ? shadowHover : shadow],
                ),
                child: widget.child,
              ),
            )));
  }
}
