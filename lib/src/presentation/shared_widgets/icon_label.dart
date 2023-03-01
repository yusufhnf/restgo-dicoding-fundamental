import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  const IconLabel(
      {super.key, required this.leftIcon, required this.label, this.textStyle});
  final Widget leftIcon;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leftIcon,
        const SizedBox(width: 5.0),
        Expanded(
          child: Text(
            label,
            style: textStyle ?? Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
