import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget getuserlist() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => getuserlistitem(doc, context))
                .toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MyDrawer(),
      body: getuserlist(),
    );
  }

  Widget getuserlistitem(
      DocumentSnapshot documentSnapshot, BuildContext context) {
    Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;

    if (_auth.currentUser?.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                      useremail: _auth.currentUser!.email.toString(),
                      receiveremail: data['email'].toString())));
        },
      );
    } else
      return Container();
  }
}
