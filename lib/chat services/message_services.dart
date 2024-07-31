import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String ChatRoomid(String senderid, String receiverid) {
    List<String> a = [senderid, receiverid];
    a.sort();
    String Chatroomid = a.join("_");
    return Chatroomid;
  }

  Future<String?> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        for (final providerProfile in user.providerData) {
          return providerProfile.email;
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
    return null;
  }

  void getMessages(String Chatroomid) async {
    await for (var snapshot in _firestore.collection(Chatroomid).snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void sendmessages(String message, String Chatroomid, String Senderemail,
      Timestamp timestamp) {
    _firestore
        .collection(Chatroomid)
        .add({'sender': Senderemail, 'text': message, 'timestamp': timestamp});
  }
}
