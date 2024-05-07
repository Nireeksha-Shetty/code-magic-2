import 'package:flutter/material.dart';

class OverlayLoader extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const OverlayLoader({super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.7),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}