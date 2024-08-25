// lib/routes/scale_transition_route.dart

import 'package:flutter/material.dart';

class ScaleTransitionRoute extends PageRouteBuilder {
  final Widget page;

  ScaleTransitionRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;

            var scaleAnimation = Tween(begin: begin, end: end).animate(
              CurvedAnimation(parent: animation, curve: curve),
            );

            return ScaleTransition(
              scale: scaleAnimation,
              child: child,
            );
          },
        );
}
