import 'package:flutter_chat/model/person.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

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
    final db = database;

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
}
