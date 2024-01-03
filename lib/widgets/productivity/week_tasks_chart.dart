import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/app/interface/productivity_status/productivity_status.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:flutter_to_do/widgets/productivity/productivity_item.dart';
import 'package:intl/intl.dart';

class WeekTasksChart extends StatefulWidget {
  const WeekTasksChart({
    super.key,
    required this.tasks,
  });

  final List<TaskModel> tasks;

  @override
  State<WeekTasksChart> createState() => _WeekTasksChartState();
}

class _WeekTasksChartState extends State<WeekTasksChart> {
  BarChartData _getChartData(List<TaskModel> tasks) {
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 6));

    Map<int, BarChartGroupData> barGroups = {};
    for (int i = 0; i <= 6; i++) {
      DateTime day = startDate.add(Duration(days: i));
      barGroups[i] = BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: tasks
                .where(
                  (task) =>
                      isSameDay(task.dateTime, day) &&
                      task.status == TaskStatus.completed,
                )
                .length
                .toDouble(),
            color: isSameDay(day, now)
                ? const Color(0xff1a56cf)
                : const Color(0xffbacbf0),
            width: 40,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    }

    return BarChartData(
      borderData: FlBorderData(show: false),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toInt().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              DateTime day = startDate.add(Duration(days: value.toInt()));
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  DateFormat('EEE').format(day).substring(0, 3),
                  style: const TextStyle(
                    color: Color(0xffd6d9db),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
      ),
      barGroups: barGroups.values.toList(),
      gridData: const FlGridData(show: false),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  int _tasksCompletedInPeriod(
    List<TaskModel> tasks,
    DateTime start,
    DateTime end,
  ) {
    return tasks
        .where(
          (task) =>
              task.dateTime.isAfter(start) &&
              task.dateTime.isBefore(end) &&
              task.status == TaskStatus.completed,
        )
        .length;
  }

  ProductivityStatus _compareTasks(int current, int previous) {
    if (current > previous) {
      return ProductivityStatus.up;
    } else if (current < previous) {
      return ProductivityStatus.down;
    } else {
      return ProductivityStatus.medium;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 6));
    String dateRange =
        '${DateFormat('d MMM').format(startDate)} - ${DateFormat('d MMM').format(now)}';
    String todayName = DateFormat('EEEE').format(now);

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime startOfLastWeek = startOfWeek.subtract(const Duration(days: 7));
    DateTime endOfLastWeek = startOfWeek.subtract(const Duration(seconds: 1));
    DateTime startOfMonth = DateTime(now.year, now.month);
    DateTime startOfLastMonth = DateTime(now.year, now.month - 1);
    DateTime endOfLastMonth = DateTime(now.year, now.month, 0);

    int tasksThisWeek = _tasksCompletedInPeriod(
      widget.tasks,
      startOfWeek,
      now,
    );
    int tasksLastWeek = _tasksCompletedInPeriod(
      widget.tasks,
      startOfLastWeek,
      endOfLastWeek,
    );
    int tasksThisMonth = _tasksCompletedInPeriod(
      widget.tasks,
      startOfMonth,
      now,
    );
    int tasksLastMonth = _tasksCompletedInPeriod(
      widget.tasks,
      startOfLastMonth,
      endOfLastMonth,
    );

    ProductivityStatus statusThisWeek = _compareTasks(
      tasksThisWeek,
      tasksLastWeek,
    );
    ProductivityStatus statusThisMonth = _compareTasks(
      tasksThisMonth,
      tasksLastMonth,
    );

    return Expanded(
      child: Column(
        children: [
          Text(
            dateRange,
            style: const TextStyle(
              color: Color(0xffc0c7d8),
              fontSize: 12,
            ),
          ),
          Text(
            todayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xff40474e),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BarChart(
              _getChartData(widget.tasks),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfff5f9fc),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductivityItem(
                  number: tasksThisWeek,
                  status: statusThisWeek,
                  title: 'THIS WEEK',
                ),
                ProductivityItem(
                  number: tasksThisMonth,
                  status: statusThisMonth,
                  title: 'THIS MONTH',
                ),
                ProductivityItem(
                  number: widget.tasks.length,
                  status: ProductivityStatus.medium,
                  title: 'ALL TASKS',
                ),
              ],
            ),
          ),
          const Spacer(flex: 2)
        ],
      ),
    );
  }
}
