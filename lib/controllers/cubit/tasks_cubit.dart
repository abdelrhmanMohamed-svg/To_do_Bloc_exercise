import 'package:bloc_exercise/models/task_model.dart';
import 'package:bloc_exercise/utilities/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  void addTask(String title) {
    final newTask =
        TaskModel(id: generateID(), title: title, isCompleted: false);
    print(" object : $newTask");
    emit(UpdateTask(List.from(state.tasks)..add(newTask)));
    print(" list : ${state.tasks}");
  }

  void deleteTask(String id) {
    final newTasks = state.tasks
        .where(
          (task) => task.id != id,
        )
        .toList();

    emit(UpdateTask(newTasks));
  }

  void toggleTask(String id) {
    final newTasks = state.tasks.map((task) {
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();

    emit(UpdateTask(newTasks));
  }
}
