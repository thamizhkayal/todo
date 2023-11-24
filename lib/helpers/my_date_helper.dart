class MyDateHelper {
  static String ddMMyyyy({required DateTime date, String splitter = "-"}) {
    return "${date.day}$splitter${date.month}$splitter${date.year}";
  }
}
