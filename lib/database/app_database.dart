import 'package:bankapp/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), "bank_app.db");
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.createTableSql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete
  );
}