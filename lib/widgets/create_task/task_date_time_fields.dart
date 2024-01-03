import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/widgets/global/cupertino_date_picker.dart';
import 'package:flutter_to_do/widgets/global/cupertino_time_picker.dart';
import 'package:intl/intl.dart';

class TaskDateTimeFields extends StatelessWidget {
  const TaskDateTimeFields({
    super.key,
    required this.time,
    required this.date,
    required this.onSelectedTime,
    required this.onSelectedDate,
  });

  final TimeOfDay? time;
  final DateTime? date;
  final Function(TimeOfDay newTime) onSelectedTime;
  final Function(DateTime newDate) onSelectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date & Time',
          style: TextStyle(
            color: Color(0xff6e7378),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          onTap: () async {
            DateTime? newDate;
            if (kIsWeb || Platform.isAndroid) {
              final now = DateTime.now();

              newDate = await showDatePicker(
                context: context,
                firstDate: DateTime(now.year, now.month, now.day - 7),
                lastDate: DateTime(now.year, now.month + 2, now.day),
                initialDate: date ?? DateTime.now(),
              );
            } else if (Platform.isIOS || Platform.isMacOS) {
              newDate = await showCupertinoModalPopup<DateTime?>(
                context: context,
                builder: (context) => MyCupertinoDatePicker(
                  date: date,
                ),
              );
            }

            if (newDate != null) {
              onSelectedDate.call(newDate);
            }
          },
          readOnly: true,
          controller: TextEditingController(
            text: date != null ? DateFormat('dd/MM/yyyy').format(date!) : '',
          ),
          decoration: InputDecoration(
            fillColor: const Color(0xfff5f9fc),
            filled: true,
            hintStyle: const TextStyle(
              color: Color(0xffcbceda),
            ),
            hintText: 'Date',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffc1d5fa),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          onTap: () async {
            TimeOfDay? newTime;
            if (kIsWeb || Platform.isAndroid) {
              newTime = await showTimePicker(
                context: context,
                initialTime: time ?? TimeOfDay.now(),
              );
            } else if (Platform.isIOS || Platform.isMacOS) {
              newTime = await showCupertinoModalPopup<TimeOfDay?>(
                context: context,
                builder: (context) => CupertinoTimePicker(
                  time: time,
                ),
              );
            }

            if (newTime != null) {
              onSelectedTime.call(newTime);
            }
          },
          readOnly: true,
          controller: TextEditingController(
            text: time != null
                ? DateFormat('HH:mm').format(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      time!.hour,
                      time!.minute,
                    ),
                  )
                : '',
          ),
          decoration: InputDecoration(
            fillColor: const Color(0xfff5f9fc),
            filled: true,
            hintStyle: const TextStyle(
              color: Color(0xffcbceda),
            ),
            hintText: 'Time',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffc1d5fa),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
        ),
      ],
    );
  }
}
