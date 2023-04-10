import 'package:flutter/material.dart';
import 'package:flutter_chat/singlechat/singlechat.dart';
import 'package:flutter_chat/model/person.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

Route _createRoute(String contactName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SingleChat(
      contactName: contactName,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class _ChatsState extends State<Chats> {
  late Database database;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  ListTile _tile(
          String title, String subtitle, String telephone, IconData icon) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        trailing: Text(
          telephone,
          style: TextStyle(color: Colors.grey),
        ),
        onTap: () {
          Navigator.of(context).push(_createRoute(title));
        },
      );
  @override
  void initState() {
    super.initState();
  }

  Future<List<Person>> sqliteDb() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    var joinPath = await _localPath;
    log('joinPath: $joinPath');
    this.database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.

      Path.join(joinPath, 'person.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          '''CREATE TABLE person(
            orderNo INTEGER PRIMARY KEY, 
            name TEXT, 
            gender TEXT, 
            politicalStatus TEXT, 
            dateOfBirth TEXT, 
            workPosition TEXT,
            city TEXT,
            telephone TEXT,
            groupType TEXT
             )
           ''',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    //插入测试数据
    await insertPerson(new Person(1, '张三', '男', '党员', '1980-02-17',
        '城云科技、高级副总裁', '杭州', '18668688686', '商界'));
    await insertPerson(new Person(2, '李四', '男', '党员', '1980-02-17', '城云科技、副总裁',
        '杭州', '18668688686', '商界'));
    await insertPerson(new Person(3, '王五', '男', '党员', '1980-02-17', '城云科技、总经理',
        '杭州', '18668688686', '商界'));
    await insertPerson(new Person(4, '赵六', '男', '党员', '1980-02-17', '城云科技、副总经理',
        '杭州', '18668688686', '商界'));
    await insertPerson(new Person(5, '刘二', '男', '党员', '1980-02-17', '城云科技、技术总监',
        '杭州', '18668688686', '商界'));
    await insertPerson(new Person(6, '上官一', '男', '党员', '1980-02-17',
        '城云科技、部门经理', '杭州', '18668688686', '商界'));
    await insertPerson(new Person(7, '欧阳二', '男', '党员', '1980-02-17',
        '城云科技、交付经理', '杭州', '18668688686', '商界'));
    await insertPerson(new Person(8, 'sara', '男', '党员', '1980-02-17', '城云科技、组长',
        '杭州', '18668688686', '商界'));

    var personList = await queryPerson();
    return personList;
  }

  // Define a function that inserts person into the database
  Future<void> insertPerson(Person person) async {
    // Get a reference to the database.
    final db = this.database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'person',
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Person>> queryPerson() async {
    // Get a reference to the database.
    final db = this.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('person');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Person(
          maps[i]['orderNo'],
          maps[i]['name'],
          maps[i]['gender'],
          maps[i]['politicalStatus'],
          maps[i]['dateOfBirth'],
          maps[i]['workPosition'],
          maps[i]['city'],
          maps[i]['telephone'],
          maps[i]['groupType']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sqliteDb(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading....');
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                List<Person> personList = snapshot.data as List<Person>;
                var chatList = List.generate(personList.length, (i) {
                  return _tile(personList[i].name, personList[i].workPosition,
                      personList[i].telephone, Icons.person);
                });
                return ListView.separated(
                  itemCount: chatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return chatList[index];
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 1,
                  ),
                );
              }
          }
        });
  }
}
