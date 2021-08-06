import 'package:flutter/material.dart';

class SingleChat extends StatelessWidget {
  final String contactName;
  SingleChat({required this.contactName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          contactName,
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
        alignment: Alignment.center,
        child: StreamBuilder<int>(
            initialData: 23,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Text(snapshot.data.toString());
            }),
      ),
      bottomNavigationBar: StickyBottomAppBar(
        child: BottomAppBar(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings_voice),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    style: TextStyle(height: 1.8),
                    showCursor: true,
                    maxLines: null,
                    onChanged: (String value) async {
                      if (value.isNotEmpty) {
                        //TODO: replace add button with send
                      }
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.face_outlined,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//reference https://github.com/flutter/flutter/issues/26499
class StickyBottomAppBar extends StatelessWidget {
  final BottomAppBar child;
  StickyBottomAppBar({required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: child,
    );
  }
}
