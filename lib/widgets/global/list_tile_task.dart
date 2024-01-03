import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:intl/intl.dart';

class ListTileTask extends StatefulWidget {
  const ListTileTask({
    super.key,
    required this.task,
    required this.onTaskCompleted,
    required this.onTaskIncompleted,
  });

  final TaskModel task;
  final Function() onTaskCompleted;
  final Function() onTaskIncompleted;

  @override
  State<ListTileTask> createState() => _ListTileTaskState();
}

class _ListTileTaskState extends State<ListTileTask> {
  Color backgroundColor = const Color(0xffdcf7fc);
  Color borderColor = const Color(0xff72d4e6);
  double progressValue = 0.0;
  Timer? timer;
  Color titleTextColor = const Color(0xff5f646a);

  @override
  void initState() {
    if (widget.task.status == TaskStatus.completed) {
      startTimer(isFirstTime: true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Text(
            widget.task.title,
            maxLines: 1,
          ),
          if (widget.task.status == TaskStatus.incompleted)
            LinearProgressIndicator(
              value: progressValue,
              color: const Color(0xffbfc9d6),
              backgroundColor: Colors.transparent,
              minHeight: 1.5,
            ),
        ],
      ),
      titleTextStyle: TextStyle(
        color: titleTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: const TextStyle(
        color: Color(0xffcbd1de),
      ),
      subtitle: Row(
        children: [
          Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.task.dateTime)),
          const SizedBox(width: 10),
          Text(widget.task.category.name.toUpperCase()),
        ],
      ),
      leading: GestureDetector(
        onTap: () {
          if (timer != null && timer!.isActive) {
            cancelTimer();
          } else {
            startTimer();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: Visibility(
            visible: progressValue == 0 ? false : true,
            child: FadeIn(
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer({bool isFirstTime = false}) {
    setState(() {
      backgroundColor = const Color(0xff2dbdd8);
      borderColor = const Color(0xff2dbdd8);
      titleTextColor =
          isFirstTime ? const Color(0xff5f646a) : const Color(0xffbfc9d6);
      if (widget.task.status == TaskStatus.incompleted || isFirstTime) {
        progressValue = 0.0;
      } else {
        progressValue = 1.0;
      }
    });

    timer = Timer.periodic(
      const Duration(milliseconds: 20),
      (Timer timer) {
        if (widget.task.status == TaskStatus.incompleted || isFirstTime) {
          if (progressValue >= 1) {
            completeActionTask(isFirstTime);
          } else {
            setState(() {
              progressValue += 0.025;
            });
          }
        } else {
          if (progressValue <= 0) {
            completeActionTask(isFirstTime);
          } else {
            setState(() {
              progressValue -= 0.05;
            });
          }
        }
      },
    );
  }

  void completeActionTask(bool isFirstTime) {
    timer?.cancel();
    if (isFirstTime) return;
    if (widget.task.status == TaskStatus.incompleted) {
      widget.onTaskCompleted.call();
    } else {
      widget.onTaskIncompleted.call();
    }
  }

  void cancelTimer() {
    timer?.cancel();

    setState(() {
      if (widget.task.status == TaskStatus.incompleted) {
        backgroundColor = const Color(0xffdcf7fc);
        borderColor = const Color(0xff72d4e6);
        titleTextColor = const Color(0xff5f646a);
        progressValue = 0.0;
      } else {
        backgroundColor = const Color(0xffd1dbdc);
        borderColor = const Color(0xffd1dbdc);
        titleTextColor = const Color(0xffbfc9d6);
        progressValue = 1.0;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
