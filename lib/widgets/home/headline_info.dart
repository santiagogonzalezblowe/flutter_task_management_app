import 'package:flutter/material.dart';

class HeadlineInfo extends StatelessWidget {
  const HeadlineInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            maxLines: 2,
            text: const TextSpan(
              text: 'Good Morning,\n',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Santiago Gonzalez',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const CircleAvatar(
          foregroundImage: NetworkImage(
            'https://aiavatargpt.com/imgs/styles/women/lowres/Anime%20Character.png',
          ),
        ),
      ],
    );
  }
}
