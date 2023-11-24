import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/constants/db_collection.dart';
import 'package:todo/task_model.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    getAllTask();
  }

  final _fs = FirebaseFirestore.instance;
  List<TaskModel> allTask = [];

  addTask({required Map<String, dynamic> taskData}) async {
    await _fs.collection(DBCollection.kTaskCollection).add(taskData);
  }

  getAllTask() async {
    final allDbTask = await _fs.collection(DBCollection.kTaskCollection).get();
    allTask.clear();
    for (var taskDoc in allDbTask.docs) {
      Map<String, dynamic> taskData = {...taskDoc.data(), "docId": taskDoc.id};
      print(taskData);
      allTask.add(TaskModel.fromMap(taskData));
    }
    ;
  }
}
