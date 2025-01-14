import 'package:flutter/material.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bought_meals_widget.dart' show BoughtMealsWidget;

class BoughtMealsModel extends FlutterFlowModel<BoughtMealsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  var scannedValue = '';
  var scan = '';
  FirebaseFirestore? firebaseFirestore;

  get getFirebaseFirestore => firebaseFirestore;

  void set setFirebaseFirestore(FirebaseFirestore? firebaseFirestore2) {
    firebaseFirestore = firebaseFirestore2;
  }

  void scanQrCode() async {
    DocumentReference<Map<String, dynamic>> documentRef = FirebaseFirestore
        .instance
        .collection("bought_ticket")
        .doc(scannedValue);

    final firebaseFirestore = this.firebaseFirestore;
    if (firebaseFirestore != null) {
      documentRef =
          firebaseFirestore.collection("bought_ticket").doc(scannedValue);
    }

    if (documentRef != null) {
      // Check if the document exists
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await documentRef.get();
      if (documentSnapshot.exists && !documentSnapshot.data()!["scanned"]) {
        // Document exists and is not scanned
        await documentRef.set({
          "scanned": true // Ticket can only be used once
        }, SetOptions(merge: true));
      }
    }
  }

  List<BoughtTicketRecord>? userTickets;

  List<bool> alreadyScanned = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<String> ticketsInfo = ['', '', '', '', '', '', '', '', '', '', '', ''];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
