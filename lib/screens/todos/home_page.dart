import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/common_widgets/add_task_bottom_sheet.dart';
import 'package:todo/constants/my_colors.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/todos/widgets/task_tail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _addTaskSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddTaskBottomSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        onPressed: () {
          _addTaskSheet(context);
        },
        child: Icon(
          Icons.add,
          size: 30.sp,
          color: MyColors.kMainColor,
        ),
      ),
      body: ListView(
          padding: EdgeInsets.only(top: 50.h),
          children: taskProvider.allTask
              .map((e) => TaskTail(
                    taskModel: e,
                  ))
              .toList()),
    );
  }
}
