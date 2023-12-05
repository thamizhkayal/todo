import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/constants/db_collection.dart';
import 'package:todo/task_model.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {}

  final _fs = FirebaseFirestore.instance;
  List<TaskModel> allTask = [];

  addTask({required Map<String, dynamic> taskData}) async {
    await _fs.collection(DBCollection.kTaskCollection).add(taskData);
  }

  toggleComplete({required TaskModel taskModel}) {
    _fs
        .collection(DBCollection.kTaskCollection)
        .doc(taskModel.id)
        .update({"status": !taskModel.status});
  }

  deleteTask({required TaskModel taskModel}) {
    _fs.collection(DBCollection.kTaskCollection).doc(taskModel.id).delete();
  }
}
