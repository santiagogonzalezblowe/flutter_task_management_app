import 'package:flutter/material.dart';
import 'package:flutter_to_do/app/interface/productivity_status/productivity_status.dart';

class ProductivityItem extends StatelessWidget {
  const ProductivityItem({
    super.key,
    required this.title,
    required this.number,
    required this.status,
  });

  final String title;
  final int number;
  final ProductivityStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$number',
              style: const TextStyle(
                color: Color(0xff444a51),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 4),
            getProductivityStatusWidget(),
          ],
        ),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xffcfd5e2),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        )
      ],
    );
  }

  Widget getProductivityStatusWidget() {
    switch (status) {
      case ProductivityStatus.medium:
        return const SizedBox.shrink();
      case ProductivityStatus.up:
        return const Icon(
          Icons.arrow_upward,
          color: Colors.green,
          size: 18,
        );
      case ProductivityStatus.down:
        return const Icon(
          Icons.arrow_downward,
          color: Colors.red,
          size: 18,
        );
    }
  }
}
