import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseService() {
    initFirebase();
  }

  initFirebase() async {
    final FirebaseApp app = await FirebaseApp.configure(
        name: 'flight-firestore',
        options: Platform.isIOS
            ? const FirebaseOptions(
                googleAppID: '1:1009830851809:ios:8658d2b8af672428',
                gcmSenderID: '805599079442',
                databaseURL: 'https://flightapp-75c15.firebaseio.com/',
              )
            : const FirebaseOptions(
                googleAppID: '1:805599079442:android:df6df940c659c7a1',
                apiKey: 'AIzaSyCsXrc7TfVdQMF5C2U2o3EjDVNz0O3Qe2g',
                databaseURL: 'https://flightapp-75c15.firebaseio.com/',
              ));
  }

  Stream<QuerySnapshot> getLocations() {
    return Firestore.instance.collection('locations').snapshots();
  }

  Stream<QuerySnapshot> getCities() {
    return Firestore.instance
        .collection('cities')
        .orderBy('newPrice')
        .snapshots();
  }

  Stream<QuerySnapshot> getDeals() {
    return Firestore.instance.collection('deals').snapshots();
  }
}