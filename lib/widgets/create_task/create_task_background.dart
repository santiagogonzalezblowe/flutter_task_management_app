import 'package:flutter/material.dart';

class CreateTaskBackground extends StatelessWidget {
  const CreateTaskBackground({
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
          child: Container(
            height: 90,
            width: 120,
            decoration: const BoxDecoration(
              color: Color(0xff1449b7),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned(
          top: 100,
          child: Container(
            height: 90,
            width: 80,
            decoration: const BoxDecoration(
              color: Color(0xff1b4fba),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 216,
          child: Container(
            height: 160,
            width: 100,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color(0xff1b52c5),
                  width: 12,
                ),
                top: BorderSide(
                  color: Color(0xff1b52c5),
                  width: 12,
                ),
                bottom: BorderSide(
                  color: Color(0xff1b52c5),
                  width: 12,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 180,
          child: Container(
            height: 80,
            width: 60,
            decoration: const BoxDecoration(
              color: Color(0xff0e43b0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned(
          top: 300,
          child: Container(
            height: 200,
            width: 140,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Color(0xff1b52c5),
                  width: 20,
                ),
                top: BorderSide(
                  color: Color(0xff1b52c5),
                  width: 20,
                ),
                bottom: BorderSide(
                  color: Color(0xff1b52c5),
                  width: 20,
                ),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 50,
          left: 10,
          child: BackButton(
            color: Colors.white,
          ),
        ),
        child,
      ],
    );
  }
}
