
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  
  Future addUserInfo(Map<String, dynamic>userInfoMap, String id) async{
    await FirebaseFirestore.instance.collection("user").doc(id).set(userInfoMap);
  }
}