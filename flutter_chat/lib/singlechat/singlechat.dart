import 'package:flutter/material.dart';
import 'package:flutter_chat/chatMsgModel.dart';

class SingleChat extends StatelessWidget {
  final String contactName;
  SingleChat({required this.contactName});
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
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
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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
