import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat app'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/LDXmrp30w2ussZW75Xab/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemBuilder: (ctx, idx) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[idx]['text']),
            ),
            itemCount: documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/LDXmrp30w2ussZW75Xab/messages')
              .add({'text': 'This was added by clicking the button'});
        },
      ),
    );
  }
}
