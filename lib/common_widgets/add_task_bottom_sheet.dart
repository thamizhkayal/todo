import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/helpers/my_date_helper.dart';
import 'package:todo/helpers/my_message_helper.dart';
import 'package:todo/helpers/my_picker_helper.dart';
import 'package:todo/providers/task_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    super.key,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController taskController = TextEditingController();
  DateTime? myDate;
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            TextField(controller: taskController),
            Row(
              children: [
                Text(MyDateHelper.ddMMyyyy(date: myDate ?? DateTime.now())),
                IconButton(
                  onPressed: () async {
                    DateTime? pickedDate =
                        await MyPickerHelper.datePicker(context);
                    myDate = pickedDate;
                    setState(() {});
                  },
                  icon: Icon(Icons.date_range),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> taskData = {
                    "task": taskController.text,
                    "date": '$myDate',
                    'status': false,
                  };
                  print(taskData);
                  await taskProvider.addTask(taskData: taskData);
                  await taskProvider.getAllTask();
                  if (context.mounted) {
                    MyMessageHelper.snackBar(context,
                        message: "Task Successfully Added");
                    Navigator.pop(context);
                  }
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
}
