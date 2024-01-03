import 'package:flutter/material.dart';
import 'package:flutter_to_do/widgets/home/daily_progress.dart';
import 'package:flutter_to_do/widgets/home/headline_info.dart';
import 'package:flutter_to_do/widgets/home/headline_tasks.dart';
import 'package:flutter_to_do/widgets/home/navigation_buttons.dart';
import 'package:flutter_to_do/widgets/home/tasks.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff141725),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    HeadlineInfo(),
                    Spacer(
                      flex: 4,
                    ),
                    DailyProgress(),
                    Spacer(),
                    Expanded(
                      flex: 8,
                      child: NavigationButtons(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: const Column(
                  children: [
                    Expanded(
                      child: HeadlineTasks(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Tasks(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
