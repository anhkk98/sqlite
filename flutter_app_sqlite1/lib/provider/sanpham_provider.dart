import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SanphamProvider {
  static Database db;

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'sanpham.db'),
        version: 1, onCreate: (Database db, int version) async {
      db.execute('''
create table Sanpham ( 
  id integer primary key autoincrement, 
  title text not null,
  text text not null)
''');
    });
  }
  static Future<List<Map<String, dynamic>>> getSanphamList() async{
    if(db == null){
      await open();
    }
    return await db.query('Sanpham');
  }
  static Future insertSanpham(Map<String,dynamic> sanpham) async {
    await db.insert('Sanpham', sanpham);
  }

  static Future updateSanpham(Map<String,dynamic> sanpham) async {
    await db.update('Sanpham', sanpham,
    where: 'id = ?',
    whereArgs: [sanpham['id']]);
  }
  static Future deleteSanpham(int id) async {
    await db.delete('Sanpham',
    where: 'id =? ',
    whereArgs: [id]);
  }
}
