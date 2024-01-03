import 'package:flutter/material.dart';

class ProductivityBackground extends StatelessWidget {
  const ProductivityBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 60,
          child: Container(
            height: 80,
            width: 100,
            decoration: const BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned(
          top: 110,
          child: Container(
            height: 60,
            width: 80,
            decoration: const BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 50,
          left: 10,
          child: Row(
            children: [
              BackButton(
                color: Colors.white,
              ),
              Text(
                'Productivity',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )
            ],
          ),
        ),
        child,
      ],
    );
  }
}
