import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/common_widgets/add_task_bottom_sheet.dart';
import 'package:todo/constants/db_collection.dart';
import 'package:todo/constants/my_colors.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/todos/widgets/task_tail.dart';
import 'package:todo/task_model.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.login))
        ],
      ),
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
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(DBCollection.kTaskCollection)
              .orderBy("date")
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              final docs = snapshot.data!.docs;

              return ListView(
                  children: docs.map((e) {
                Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                Timestamp date = data['date'];

                Map<String, dynamic> taskData = {
                  ...data,
                  "docId": e.id,
                  "date": date.toDate().toString()
                };

                return TaskTail(taskModel: TaskModel.fromMap(taskData));
              }).toList());
            }
          },
        ),
      ),
    );
  }
}
