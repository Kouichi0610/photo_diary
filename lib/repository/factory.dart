import 'package:flutter/foundation.dart';
import 'diary_read_writer.dart';
import 'sql_read_writer.dart';
import 'local_read_writer.dart';

DiaryReadWriter CreateDiaryReadWriter() {
  if (kIsWeb) {
    return LocalReadWriter();
  }
  return SqlReadWriter();
}
