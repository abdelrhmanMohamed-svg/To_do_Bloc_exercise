part of 'tasks_cubit.dart';

sealed class TasksState extends Equatable {
  final List<TaskModel> tasks;

  const TasksState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

final class TasksInitial extends TasksState {
  TasksInitial() : super([]);
}

final class UpdateTask extends TasksState {
  const UpdateTask(super.tasks);
}
