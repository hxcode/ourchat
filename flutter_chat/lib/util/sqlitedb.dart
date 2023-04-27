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

      Path.join(joinPath, 'person_20230427.db'),
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
            groupType TEXT,
            industry TEXT,
            techLevel TEXT,
            topSchool TEXT,
            birthWhere TEXT,
            birthWhereContact TEXT,
            birthWhereContactPhone TEXT,
            family TEXT
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
  Future<List<Person>> queryPerson(
      String selectedCondition, String searchValue) async {
    // Get a reference to the database.
    final db = database;
    //Query condition
    var conditionColumn = [
      'name',
      'politicalStatus',
      'workPosition',
      'city',
      'telephone',
      'groupType',
      'dateOfBirth'
    ];
    //页面查询条件：全部条件
    String concatWhere = conditionColumn.reduce((value, element) {
      if (value == 'name') {
        return value + ' like ?' + ' or ' + element + ' like ?';
      } else {
        return value + ' or ' + element + ' like ?';
      }
    });
    List<String> conditionArgs = List.generate(
        conditionColumn.length, (index) => '%' + searchValue + '%');
    // Query the table for all The Dogs.
    List<Map<String, dynamic>> maps = await db.query('person',
        where: concatWhere, whereArgs: conditionArgs, limit: 50);
    //页面查询条件：所属城市
    if (selectedCondition == 'city') {
      maps = await db.query('person',
          where: 'city like ?', whereArgs: [conditionArgs[0]], limit: 50);
    }
    //页面查询条件：所属界别
    if (selectedCondition == 'groupType') {
      maps = await db.query('person',
          where: 'groupType like ?', whereArgs: [conditionArgs[0]], limit: 50);
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
          orderNo: maps[i]['orderNo'],
          name: maps[i]['name'],
          gender: maps[i]['gender'],
          politicalStatus: maps[i]['politicalStatus'],
          dateOfBirth: dateOfBirth,
          workPosition: maps[i]['workPosition'],
          city: maps[i]['city'],
          telephone: maps[i]['telephone'],
          groupType: maps[i]['groupType'],
          industry: maps[i]['industry'],
          techLevel: maps[i]['techLevel'],
          topSchool: maps[i]['topSchool'],
          birthWhere: maps[i]['birthWhere'],
          birthWhereContact: maps[i]['birthWhereContact'],
          birthWhereContactPhone: maps[i]['birthWhereContactPhone'],
          family: maps[i]['family']);
    });
  }
}
