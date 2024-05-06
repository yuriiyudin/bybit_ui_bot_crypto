import 'package:flutter/material.dart';
import 'package:terminal_octopus/src/constants/theme.dart';

class CoverWidget extends StatelessWidget {
  const CoverWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          stops: [0.3, 0.7, 1.0],
          end: Alignment.bottomCenter,
          colors: [kDefaultbackgroundColor, Color.fromARGB(255, 22, 18, 50), Color.fromARGB(255, 12, 10, 29)],
        ),
      ),
      child: child,
    );
  }
}
