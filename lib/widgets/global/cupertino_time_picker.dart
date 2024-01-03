import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CupertinoTimePicker extends StatefulWidget {
  const CupertinoTimePicker({
    super.key,
    required this.time,
  });

  final TimeOfDay? time;

  @override
  State<CupertinoTimePicker> createState() => _CupertinoTimePickerState();
}

class _CupertinoTimePickerState extends State<CupertinoTimePicker> {
  final now = DateTime.now();
  late TimeOfDay? timeOfDay;

  @override
  void initState() {
    timeOfDay = widget.time ?? TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.34,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CupertinoDatePicker(
              onDateTimeChanged: (value) {
                timeOfDay = TimeOfDay.fromDateTime(value);
              },
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              initialDateTime: timeOfDay == null
                  ? null
                  : DateTime(
                      now.year,
                      now.month,
                      now.day,
                      timeOfDay!.hour,
                      timeOfDay!.minute,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop(timeOfDay);
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
