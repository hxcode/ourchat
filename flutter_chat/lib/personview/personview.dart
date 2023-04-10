import 'package:flutter/material.dart';
import 'package:flutter_chat/model/person.dart';

class PersonView extends StatelessWidget {
  final Person person;
  PersonView({required this.person});
  @override
  Widget build(BuildContext context) {
    Map<String, String> props = {
      'name': '姓名',
      'gender': '性别',
      'groupType': '界别',
      'politicalStatus': '政治面貌',
      'dateOfBirth': '出生日期',
      'workPosition': '工作单位及职务',
      'city': '现居城市',
      'telephone': '联系方式',
    };
    var personMap = person.toMap();
    var itemList = [];
    for (var key in props.keys) {
      itemList.add(ListTile(
        leading: Text((props[key] as String) + ": ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            )),
        trailing: Text(
          personMap[key],
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          this.person.name,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: props.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: itemList[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
