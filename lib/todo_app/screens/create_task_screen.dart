import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo_app/todo_app/config/routes/routes_location.dart';
import 'package:flutter_riverpod_todo_app/todo_app/data/models/task.dart';
import 'package:flutter_riverpod_todo_app/todo_app/providers/category_provider.dart';
import 'package:flutter_riverpod_todo_app/todo_app/providers/date_provider.dart';
import 'package:flutter_riverpod_todo_app/todo_app/providers/task/tasks_provider.dart';
import 'package:flutter_riverpod_todo_app/todo_app/providers/time_provider.dart';
import 'package:flutter_riverpod_todo_app/todo_app/utils/app_alerts.dart';
import 'package:flutter_riverpod_todo_app/todo_app/utils/extensions.dart';
import 'package:flutter_riverpod_todo_app/todo_app/utils/helpers.dart';
import 'package:flutter_riverpod_todo_app/todo_app/widgets/categories_selection.dart';
import 'package:flutter_riverpod_todo_app/todo_app/widgets/common_text_field.dart';
import 'package:flutter_riverpod_todo_app/todo_app/widgets/display_white_text.dart';
import 'package:flutter_riverpod_todo_app/todo_app/widgets/select_date_time.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const DisplayWhiteText(
          text: 'Add New Task',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                hintText: 'Task Title',
                title: 'Task Title',
                controller: _titleController,
              ),
              const Gap(30),
              const CategoriesSelection(),
              const Gap(30),
              const SelectDateTime(),
              const Gap(30),
              CommonTextField(
                hintText: 'Notes',
                title: 'Notes',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: createTask,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayWhiteText(
                    text: 'Save',
                  ),
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        note: note,
        isCompleted: false,
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Task create successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }
}