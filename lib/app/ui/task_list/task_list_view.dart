import 'package:curso_flutter/app/models/task.dart';
import 'package:curso_flutter/app/repository/task_repository.dart';
import 'package:curso_flutter/app/ui/components/h1_title.dart';
import 'package:curso_flutter/app/ui/components/shape.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderTasksView(),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: taskRepository.getTasks(),
              builder: (context, snapShot) {
                if(snapShot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                    );
                }
                if(!snapShot.hasData || snapShot.data!.isEmpty){
                  return const Center(
                    child: Text('No existen tareas'),
                  );
                }
                return _TaskListView(
                snapShot.data!, 
                onTaskDoneChange: (task){
                  task.done = !task.done;
                  taskRepository.saveTasks(snapShot.data!);
                  setState(() {

                  });
                }
                );
              }
            ),
          ),
        ],
       ),
       floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTaskModal(context),
        child: const Icon(Icons.add, size: 50,),
       ),
    );
  }

  void _showNewTaskModal(BuildContext context){
  showModalBottomSheet(
    context: context, 
    isScrollControlled: true,
    builder: (_) => _NewTaskModal(
      onTaskCreated: (Task task) {
        taskRepository.addTask(task);
      setState(() { });
    })
  );
  }

}



class _NewTaskModal extends StatelessWidget {
  _NewTaskModal({super.key, required this.onTaskCreated});

  final _controller = TextEditingController();
  final void Function(Task task) onTaskCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 33,
        vertical: 23
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const H1Title('Nueva tarea'),
          const SizedBox(height: 26),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              ),
              hintText: 'Descripción de la tarea',
            ),
          ),
          const SizedBox(height: 26),
          ElevatedButton(
            onPressed: (){
              if (_controller.text.isNotEmpty){
                final task = Task(_controller.text);
                onTaskCreated(task);
                Navigator.of(context).pop();
              }
            }, 
            child: Text('Guardar')
            ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task,{this.onTap, super.key});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
          child: Row(
            children: [
             Icon(
              task.done
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank,
              color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Text(task.title),
            ],
          ),
        )),
    );
  }
}

class _HeaderTasksView extends StatelessWidget {
  const _HeaderTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const Row(children: [ShapeCircle()],),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset('assets/images/tasks-list-image.png', width: 120, height: 120),
                    const SizedBox(height: 16),
                    const H1Title('Completa tus tareas', color: Colors.white,),
                    const SizedBox(height: 24)
                  ],
                )
              ],
               ),
          );
  }
}

class _TaskListView extends StatelessWidget {
  const _TaskListView(this.taskList,{super.key, required this.onTaskDoneChange});

  final List<Task> taskList;
  final void Function(Task task) onTaskDoneChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1Title('Tareas'),
          Expanded(
            child: ListView.separated(
              itemCount: taskList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) => _TaskItem(taskList[index], 
              onTap: () => onTaskDoneChange(taskList[index]),
              ),  
              ),
          ),
        ],
      ),
    );
  }
}

