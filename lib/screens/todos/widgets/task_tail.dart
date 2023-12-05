import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/db_collection.dart';
import 'package:todo/constants/my_colors.dart';
import 'package:todo/helpers/my_date_helper.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/task_model.dart';

class TaskTail extends StatelessWidget {
  TaskTail({super.key, required this.taskModel});

  final TaskModel taskModel;
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of(context);
    return Dismissible(
      key: globalKey,
      onDismissed: (details) {
        taskProvider.deleteTask(taskModel: taskModel);
      },
      child: ListTile(
        title: Text(
          taskModel.task,
          style: TextStyle(
              color: taskModel.status
                  ? MyColors.kSecondaryColor
                  : MyColors.kMainColor,
              fontSize: 20,
              decoration: taskModel.status ? TextDecoration.lineThrough : null),
        ),
        tileColor: Colors.white,
        subtitle: Text(MyDateHelper.ddMMyyyy(date: taskModel.date)),
        trailing: IconButton(
          color:
              taskModel.status ? MyColors.kSecondaryColor : MyColors.kMainColor,
          icon: Icon(taskModel.status
              ? Icons.check_box
              : Icons.check_box_outline_blank),
          splashRadius: 25.r,
          onPressed: () {
            taskProvider.toggleComplete(taskModel: taskModel);
          },
        ),
        onTap: () {
          print(taskModel.id);
        },
      ),
    );
  }
}
