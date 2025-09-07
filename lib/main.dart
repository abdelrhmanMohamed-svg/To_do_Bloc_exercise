import 'package:bloc_exercise/controllers/cubit/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To Do App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _titleContorller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _titleContorller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: state.tasks.isEmpty
                    ? Text(
                        "there is no tasks",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : ListView.builder(
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return ListTile(
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (value) {
                                context.read<TasksCubit>().toggleTask(task.id);
                              },
                            ),
                            title: Text(task.title),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<TasksCubit>().deleteTask(task.id);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
              );
            },
          ),
        ),
        floatingActionButton: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 250,
                        width: 250,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            TextField(
                              controller: _titleContorller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Add Task",
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_titleContorller.text.isEmpty) return;
                                  context
                                      .read<TasksCubit>()
                                      .addTask(_titleContorller.text);
                                  Navigator.maybePop(context);
                                  _titleContorller.clear();
                                },
                                child: Text(
                                  "Add Task",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
