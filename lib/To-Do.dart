import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final TextEditingController _taskController=TextEditingController();
  List<Map<String,dynamic>> tasks=[];
  void _addtasks(){
    String task = _taskController.text.trim();
    if(task.isNotEmpty){
      setState(() {
        tasks.add({
          "title":_taskController.text,
          "isDone":false,
        });
        _taskController.clear();
      });
    }
  }
  void _deletetasks(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }
  void _toggletask(int index){
    setState(() {
      tasks[index]['isDone']=!tasks[index]['isDone'];
    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlue,centerTitle:true,title:Text('To-Do-App' ,style: TextStyle(fontWeight: FontWeight.w900,)),
    ),
      body:Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsetsGeometry.all(29),
          child:Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Enter a task',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(onPressed: _addtasks, child: Text('Add')),
            ],

          ),
          ),
          Expanded(child:tasks.isEmpty?Center(child: Text('No tasks added yet')):ListView.builder(itemCount: tasks.length,itemBuilder: (context,index){
            return Card(
              child: ListTile(
                leading: Checkbox(
                  value:tasks[index]['isDone'],
                  onChanged:(value){
                    setState(() {
                      tasks[index]['isDone'] = value!;
                    });
              },
                ),
                title: Text(tasks[index]["title"]),
                trailing: IconButton(onPressed: ()=>_deletetasks(index), icon: Icon(Icons.delete,color: Colors.red,)),
              ),

            );
          }))
        ],
      ),
    );
  }
}
