class TaskModel {
  final String id;
  final String task;
  final String email;
  final DateTime date;
  final bool status;

  TaskModel(
      {required this.id,
      required this.task,
      required this.date,
      required this.email,
      this.status = false});

  factory TaskModel.fromMap(data) {
    DateTime dbData = DateTime.parse(data['date']);
    return TaskModel(
        id: data['docId'],
        task: data['task'],
        email: data['email'],
        date: dbData,
        status: data['status']);
  }
}
