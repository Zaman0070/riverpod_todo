import 'package:flutter_riverpod_todo_app/todo_app/config/routes/routes_location.dart';
import 'package:flutter_riverpod_todo_app/todo_app/config/routes/routes_provider.dart';
import 'package:flutter_riverpod_todo_app/todo_app/screens/create_task_screen.dart';
import 'package:flutter_riverpod_todo_app/todo_app/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];
