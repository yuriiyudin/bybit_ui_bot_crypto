import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_octopus/src/constants/theme.dart';
import 'package:terminal_octopus/src/features/dashboard/widgets/cover_widget.dart';

class SignalsScreen extends ConsumerWidget {
  const SignalsScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: AppBar(), body: const CoverWidget());
  }
}
