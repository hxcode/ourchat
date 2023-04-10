import 'package:flutter/material.dart';
import 'package:flutter_chat/personview/personview.dart';
import 'package:flutter_chat/model/person.dart';
import 'package:flutter_chat/util/sqlitedb.dart';

class NbPerson extends StatefulWidget {
  final String searchValue;
  NbPerson({required this.searchValue});
  @override
  _NbPersonState createState() => _NbPersonState();
}

Route _createRoute(Person person) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PersonView(
      person: person,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class _NbPersonState extends State<NbPerson> {
  ListTile _tile(Person person, IconData icon) => ListTile(
        title: Text(person.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(person.workPosition),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        trailing: Text(
          person.telephone,
          style: TextStyle(color: Colors.grey),
        ),
        onTap: () {
          Navigator.of(context).push(_createRoute(person));
        },
      );
  @override
  void initState() {
    super.initState();
  }

  Future<List<Person>> sqliteDb(String searchValue) async {
    WidgetsFlutterBinding.ensureInitialized();
    GlobalDb globalDb;
    globalDb = new GlobalDb();
    await globalDb.initDb();
    var personList = await globalDb.queryPerson(searchValue);
    return personList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sqliteDb(widget.searchValue),
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
                  return _tile(personList[i], Icons.person);
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
