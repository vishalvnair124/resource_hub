// lib/routes/zoom_transition_route.dart

import 'package:flutter/material.dart';

class ZoomTransitionRoute extends PageRouteBuilder {
  final Widget page;

  ZoomTransitionRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;

            var zoomAnimation = Tween(begin: begin, end: end).animate(
              CurvedAnimation(parent: animation, curve: curve),
            );

            return ScaleTransition(
              scale: zoomAnimation,
              child: child,
            );
          },
        );
}
