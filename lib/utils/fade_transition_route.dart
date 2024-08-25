import 'package:flutter/material.dart';

class FadeTransitionRoute extends PageRouteBuilder {
  final Widget page;

  FadeTransitionRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation =
                animation.drive(tween.chain(CurveTween(curve: curve)));
            final opacityAnimation =
                animation.drive(Tween(begin: 0.0, end: 1.0));

            return FadeTransition(
              opacity: opacityAnimation,
              child: SlideTransition(position: offsetAnimation, child: child),
            );
          },
        );
}
