import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyCupertinoDatePicker extends StatefulWidget {
  const MyCupertinoDatePicker({
    super.key,
    required this.date,
  });

  final DateTime? date;

  @override
  State<MyCupertinoDatePicker> createState() => _MyCupertinoDatePickerState();
}

class _MyCupertinoDatePickerState extends State<MyCupertinoDatePicker> {
  late DateTime? dateTime;

  @override
  void initState() {
    dateTime = widget.date ?? DateTime.now();
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
                dateTime = value;
              },
              mode: CupertinoDatePickerMode.date,
              initialDateTime: dateTime,
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
                      context.pop(dateTime);
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
