import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:research_job/Connection_Campus/global_variables.dart';


class Persistent {
  static List<String> jobCategoryList = [
    "Computer Science",
    "Information Technology",
    "Electrical Engineering",
    "Mechanical Engineering",
    "Civil Engineering",
    "Chemical Engineering",
    "Biomedical Engineering",
    "Aerospace Engineering",
    "Data Science",
    "Artificial Intelligence",
    "Software Engineering",
    "MBA",
    "IoT & Cyber Security",
    "Automobile Engineering",
    
  ];


   void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

      name = userDoc.get("name");
      userImage = userDoc.get("userImage");
      location = userDoc.get("location");
  }





  static void updateJobCategoryList(List<String> newCategories) {
    jobCategoryList = newCategories;
  }
}