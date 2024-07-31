import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/task.dart';

class TasksViewModel extends StateNotifier<List<Task>> {
  TasksViewModel([List<Task>? allTasks]) : super(allTasks ?? <Task>[]);

  void toggleTask(int index, bool isDone) {
    state[index] = state[index].copyWith(done: isDone);
    state = [...state];
  }
}
