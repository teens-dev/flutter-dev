import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController nameController =  TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> tasks = [];

  void addTask() {
    if (formKey.currentState!.validate()) {

      setState(() {
        tasks.add({
          "name":nameController.text,
          "email":emailController.text,
          "title": taskController.text,
          "done": false
        });
      });
      nameController.clear();
      emailController.clear();
      taskController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Task Added"))
      );
    }
  }

  void deleteTask(int index) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete?"),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),

          TextButton(
            onPressed: () {
              setState(() {
                tasks.removeAt(index);
              });

              Navigator.pop(context);
            },
            child: Text("Delete"),
          )
        ],
      ),
    );
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do App"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Enter Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "Enter Task",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Task cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              )


            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: addTask,
              child: Text("Add Task"),
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {

                  return ListTile(

                    leading: Checkbox(
                      value: tasks[index]["done"],
                      onChanged: (value) {
                        toggleTask(index);
                      },
                    ),

                    title: Text(
                      tasks[index]["title"],
                      style: TextStyle(
                        decoration: tasks[index]["done"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${tasks[index]["name"]}"),
                        Text("Email: ${tasks[index]["email"]}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTask(index);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}