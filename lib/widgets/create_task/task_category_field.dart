import 'package:flutter/material.dart';
import 'package:flutter_to_do/app/extensions/strings_extensions.dart';
import 'package:flutter_to_do/app/interface/task_category/task_category.dart';

class TaskCategoryField extends StatelessWidget {
  const TaskCategoryField({
    super.key,
    required this.category,
    required this.onSelected,
  });

  final TaskCategory category;
  final Function(TaskCategory newCategory) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: Color(0xff6e7378),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ...TaskCategory.values.map((e) {
              final isSelected = e == category;
              return Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: ChoiceChip(
                  label: Text(e.name.capitalize()),
                  selected: isSelected,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? const Color(0xffe2ecfd)
                        : const Color(0xff4675da),
                  ),
                  elevation: isSelected ? 2 : 0,
                  side: isSelected ? BorderSide.none : null,
                  onSelected: (value) {
                    if (value) {
                      onSelected.call(e);
                    }
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
