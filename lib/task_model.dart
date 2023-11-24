class TaskModel {
  final String id;
  final String task;
  final DateTime date;
  final bool status;

  TaskModel(
      {required this.id,
      required this.task,
      required this.date,
      this.status = false});

  factory TaskModel.fromMap(data) {
    DateTime dbData = DateTime.parse(data['date']);
    return TaskModel(
        id: data['docId'],
        task: data['task'],
        date: dbData,
        status: data['status']);
  }
}
