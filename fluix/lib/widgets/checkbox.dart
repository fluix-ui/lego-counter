import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluix/theme/theme.dart';

class CheckBox extends StatefulWidget {
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final String label;
  final Size size;

  CheckBox({this.value, this.onChanged, this.label, this.enabled = false, this.size = const Size(24,24)});

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<CheckBox> {
  bool isFocused = false;

  void focus(bool shouldFocus) {
    if (!isDisabled) {
      setState(() {
        isFocused = shouldFocus;
      });
    }
  }

  void setValue() {
    if (!isDisabled) {
      widget.onChanged(!widget.value);
      setState(() {
        isFocused = false;
      });
    }
  }

  bool get isDisabled => widget.enabled != null || !widget.enabled;

  @override
  Widget build(BuildContext context) {

    var theme = FluidTheme.of(context);

    Widget res = _CheckBoxContainer(
      color: theme.primary,
      inactive: theme.disabledColor,
      isFocused: isFocused,
      value: widget.value,
      size: widget.size,
    );

    if (widget.label != null)
      res = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          res,
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              widget.label,
              style: TextStyle(color: isDisabled ? Color(0x2e000000) : null,fontSize: widget.size.height * 0.7),
            ),
          )
        ],
      );

    return GestureDetector(
      onTapDown: (_) => focus(true),
      onTapCancel: () => focus(false),
      onTapUp: (_) => setValue(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: res,
      ),
    );
  }
}

class _CheckBoxContainer extends StatelessWidget {
  final bool isFocused;
  final bool value;
  final Color color;
  final Color inactive;
  final Size size;

  _CheckBoxContainer({this.value, this.inactive, this.color, this.isFocused,this.size});

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    if (value != null && value)
      return Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size.width * 0.3),
          boxShadow: isFocused
              ? [BoxShadow(blurRadius: 2, color: Color(0x0a00000))]
              : null,
        ),
        child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
            padding: const EdgeInsets.all(2),
            child: CustomPaint(
              foregroundPainter: _DashPainter(Colors.white),
            ),
          ),
        ),
      );

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocused ? color : inactive,
          width: 3, 
        ),
        borderRadius: BorderRadius.circular(size.width * 0.3),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color color;
  _DashPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 7;
    double cX = size.width / 2;
    double cY = size.height / 2;
    Path dashPath = Path()
      ..moveTo(cX * 0.5, cY * 0.95)
      ..lineTo(cX * 0.85, cY * 1.3)
      ..lineTo(cX * 1.5, cY * 0.7);
    canvas.drawPath(dashPath, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
