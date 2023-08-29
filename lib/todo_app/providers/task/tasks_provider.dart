import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo_app/todo_app/data/repositories/task_repository_provider.dart';
import 'package:flutter_riverpod_todo_app/todo_app/providers/task/task_notifier.dart';
import 'package:flutter_riverpod_todo_app/todo_app/providers/task/task_state.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
