import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lista de Tarefas',
        theme: ThemeData(
           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
        ),
        home: TaskListScreen());
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final List<Task> _tasks = [];

  void _addTask() {
    setState(() {
      _tasks.add(Task(name: _controller1.text));
      _controller1.clear();
    });
  }

  void _toogleTaskCompleted(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nova Tarefa',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Adicionar tarefa'),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _tasks.length,
                separatorBuilder: ( context, index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(
                      task.name,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        _toogleTaskCompleted(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
