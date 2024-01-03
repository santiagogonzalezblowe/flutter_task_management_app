import 'package:card_swiper/card_swiper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/app/extensions/strings_extensions.dart';
import 'package:flutter_to_do/app/interface/task_category/task_category.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:intl/intl.dart';

class TasksChart extends StatefulWidget {
  const TasksChart({
    super.key,
    required this.tasks,
  });

  final List<TaskModel> tasks;

  @override
  State<TasksChart> createState() => _TasksChartState();
}

class _TasksChartState extends State<TasksChart> {
  final swiperController = SwiperController();
  late List<String> months;
  int swiperIndex = 0;

  @override
  void initState() {
    super.initState();
    months = _getMonths(widget.tasks);
    swiperIndex = months.isNotEmpty ? months.length - 1 : 0;
  }

  List<String> _getMonths(List<TaskModel> tasks) {
    var distinctMonths = {
      for (var task in tasks) DateFormat('yyyy-MM').format(task.dateTime),
    };
    var sortedMonths = distinctMonths.toList()..sort();
    return sortedMonths
        .map((e) => DateFormat('MMMM').format(DateFormat('yyyy-MM').parse(e)))
        .toList();
  }

  BarChartData _getChartData(List<TaskModel> tasks, String month) {
    DateTime? latestDate;
    for (var task in tasks) {
      if (DateFormat('MMMM').format(task.dateTime) == month) {
        if (latestDate == null || task.dateTime.isAfter(latestDate)) {
          latestDate = task.dateTime;
        }
      }
    }

    if (latestDate == null) {
      return BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: true),
        barGroups: [],
        gridData: const FlGridData(show: false),
      );
    }

    Map<int, int> dayCounts = {};
    for (int i = 0; i < 7; i++) {
      DateTime day = latestDate.subtract(Duration(days: i));
      dayCounts[day.day] = 0;
    }

    for (var task in tasks) {
      if (DateFormat('MMMM').format(task.dateTime) == month &&
          dayCounts.containsKey(task.dateTime.day)) {
        dayCounts[task.dateTime.day] = (dayCounts[task.dateTime.day] ?? 0) + 1;
      }
    }

    List<BarChartGroupData> barGroups = dayCounts.entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: const Color(0xff1097b0),
            width: 26,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    }).toList();

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
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  value.toInt().toString(),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value == 0) {
                return const SizedBox.shrink();
              }
              return Text(value.toInt().toString());
            },
          ),
        ),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
      ),
      barGroups: barGroups.reversed.toList(),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xffd6eef2),
            dashArray: [4],
            strokeWidth: 1.5,
          );
        },
      ),
    );
  }

  PieChartData _getPieChartData(List<TaskModel> tasks, String month) {
    Map<TaskCategory, int> categoryCounts = {};

    for (var task in tasks) {
      if (DateFormat('MMMM').format(task.dateTime) == month) {
        categoryCounts[task.category] =
            (categoryCounts[task.category] ?? 0) + 1;
      }
    }

    int totalTasks = categoryCounts.values.fold(0, (sum, count) => sum + count);

    List<PieChartSectionData> sections = [];
    categoryCounts.forEach((category, count) {
      final percentage = (count / totalTasks) * 100;
      final section = PieChartSectionData(
        color: _getColorForCategory(category),
        value: count.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 70,
        showTitle: true,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.50,
      );
      sections.add(section);
    });

    return PieChartData(
      sections: sections,
      centerSpaceRadius: 40,
      sectionsSpace: 2,
    );
  }

  Color _getColorForCategory(TaskCategory category) {
    switch (category) {
      case TaskCategory.personal:
        return Colors.blue;
      case TaskCategory.work:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = widget.tasks
        .where((task) => task.status == TaskStatus.completed)
        .toList();

    return Column(
      children: [
        Expanded(
          child: Swiper(
            controller: swiperController,
            itemCount: months.length,
            loop: false,
            viewportFraction: 0.3,
            scale: 0.2,
            index: swiperIndex,
            itemBuilder: (context, index) {
              var isSelected = swiperIndex == index;
              return Center(
                child: Text(
                  months[index],
                  style: TextStyle(
                    fontSize: isSelected ? 22 : 18,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? const Color(0xff434b52)
                        : const Color(0xffbfc2c4),
                  ),
                ),
              );
            },
            onIndexChanged: (index) {
              setState(() {
                swiperIndex = index;
              });
            },
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Completed Tasks',
                  style: TextStyle(
                    color: Color(0xff5f646b),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BarChart(
                    _getChartData(
                      completedTasks,
                      months[swiperIndex],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task Type',
                  style: TextStyle(
                    color: Color(0xff5f646b),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: PieChart(
                          _getPieChartData(
                            widget.tasks,
                            months[swiperIndex],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...TaskCategory.values.map(
                              (e) => Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: _getColorForCategory(e),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(e.name.capitalize()),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
