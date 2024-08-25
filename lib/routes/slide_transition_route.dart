// lib/routes/slide_transition_route.dart

import 'package:flutter/material.dart';

class SlideTransitionRoute extends PageRouteBuilder {
  final Widget page;

  SlideTransitionRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide in from right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end);
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            var offsetAnimation = tween.animate(curvedAnimation);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
