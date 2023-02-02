import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
final String USER_COLLECTION = "users";
class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Map? currentUser;

  FirebaseService();

  Future<bool> loginUser({
    required String email,
    required String password
  }) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        currentUser = await getUserData(uid: userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async{
    DocumentSnapshot doc = await _db.collection(USER_COLLECTION).doc(uid).get();
    return doc.data() as Map;
  }
}
