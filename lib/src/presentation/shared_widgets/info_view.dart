import 'package:flutter/material.dart';

enum InfoType { info, error }

class InfoView extends StatelessWidget {
  final String label;
  final InfoType type;
  final VoidCallback? onTapAction;
  const InfoView(
      {super.key,
      required this.label,
      this.type = InfoType.info,
      this.onTapAction});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              type == InfoType.error
                  ? const Icon(Icons.error, color: Colors.red, size: 80)
                  : const Icon(Icons.info, color: Colors.amber, size: 80),
              const SizedBox(height: 20.0),
              Text(label),
              const SizedBox(height: 20.0),
              if (type == InfoType.error && onTapAction != null)
                MaterialButton(
                  color: Colors.red,
                  onPressed: onTapAction,
                  child: const Text(
                    "Try Again",
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
