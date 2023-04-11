import 'package:flutter_chat/model/person.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';
import 'package:intl/intl.dart';

class GlobalDb {
  late Database database;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Database get getDatabase {
    return this.database;
  }

  Future<void> initDb() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.

    var joinPath = await _localPath;
    // log('joinPath: $joinPath');
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
  Future<List<Person>> queryPerson(String searchValue) async {
    // Get a reference to the database.
    final db = database;

    // Query the table for all The Dogs.
    List<Map<String, dynamic>> maps = await db.query('person',
        where: 'name like ?', whereArgs: ['%' + searchValue + '%'], limit: 50);
    //Query condition
    var queryColumn = [
      'politicalStatus',
      'workPosition',
      'city',
      'telephone',
      'groupType',
      'dateOfBirth'
    ];
    for (var column in queryColumn) {
      if (maps.length > 0) {
        break;
      }
      maps = await db.query('person',
          where: column + ' like ?',
          whereArgs: ['%' + searchValue + '%'],
          limit: 50);
    }
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    var outputFormat = DateFormat('yyyy-MM-dd');
    return List.generate(maps.length, (i) {
      var dateOfBirth = maps[i]['dateOfBirth'];
      if (dateOfBirth.length > 20) {
        var inputDate =
            inputFormat.parse(maps[i]['dateOfBirth']); // <-- dd/MM 24H format
        dateOfBirth = outputFormat.format(inputDate);
      }

      return Person(
          maps[i]['orderNo'],
          maps[i]['name'],
          maps[i]['gender'],
          maps[i]['politicalStatus'],
          dateOfBirth,
          maps[i]['workPosition'],
          maps[i]['city'],
          maps[i]['telephone'],
          maps[i]['groupType']);
    });
  }
}
