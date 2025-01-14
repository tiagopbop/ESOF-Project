import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../sigarraApi/session.dart';
import '../../sigarraApi/sigarraApi.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'qr_code_model.dart';

export 'qr_code_model.dart';

class QrCodeWidget extends StatefulWidget {
  QrCodeWidget({
    super.key,
    required this.qrCodeValue,
  });

  final String? qrCodeValue;

  @override
  State<QrCodeWidget> createState() => _QrCodeWidgetState();
}

class _QrCodeWidgetState extends State<QrCodeWidget> {
  late QrCodeModel _model;
  Timer? _timer;
  bool _scanned = true;
  bool _isLoading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void queryFirebase() async {
    DocumentReference<Map<String, dynamic>> documentRef = FirebaseFirestore
        .instance
        .collection("bought_ticket")
        .doc(widget.qrCodeValue);

    if (documentRef != null) {
      // Check if the document exists
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await documentRef.get();
      if (documentSnapshot.exists) {
        _model.upCode = documentSnapshot.data()!["upCode"];
        _model.email = documentSnapshot.data()!["uid"];
        _model.type = documentSnapshot.data()!["type"];
        _model.fullDish = documentSnapshot.data()!["fullDish"];

        if (!_dispose) {
          setState(() {});
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QrCodeModel());

    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      DocumentReference<Map<String, dynamic>> documentRef = FirebaseFirestore
          .instance
          .collection("bought_ticket")
          .doc(widget.qrCodeValue);
      if (documentRef != null) {
        // Check if the document exists
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await documentRef.get();
        if (documentSnapshot.exists) {
          _scanned = documentSnapshot.data()!["scanned"];

          if (!_dispose) {
            setState(() {
              if (_scanned) _timer!.cancel();
            });
          }
        }
      }
    });

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!_dispose) {
        setState(() {
          _isLoading = true;
        });
      }

      // Query device store info for sigarra login.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Session? session = await sigarraLogin(
          prefs.getString('user_up_code')!, prefs.getString('user_password')!);

      if (session == null) {
        context.go('/sigarraLogin');
        return;
      }
      queryFirebase();
      await queryUserBoughtTicketsRecordOnce(
        queryBuilder: (userBoughtTicketsRecord) =>
            userBoughtTicketsRecord.where(
          'upCode',
          isEqualTo: session.username,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);

      if (!_dispose) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  bool _dispose = false;

  @override
  void dispose() {
    try {
      if (_timer != null) {
        _timer!.cancel();
      }
      _dispose = true;
      super.dispose();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E1F1F),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'QRCode - Meal',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: _isLoading
            ? Center(child: SpinningFork())
            : SafeArea(
                top: true,
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Type: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  _model.fullDish
                                      ? 'Full meal'
                                      : 'Only main dish',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Food type: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  _model.type,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'User email: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  _model.email,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'User upcode: ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  _model.upCode,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      if (!_scanned)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: BarcodeWidget(
                                  data: widget.qrCodeValue!,
                                  barcode: Barcode.qrCode(),
                                  width: MediaQuery.sizeOf(context).width * 0.6,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  backgroundColor: Colors.transparent,
                                  errorBuilder: (context, error) => SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.6,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.5,
                                  ),
                                  drawText: false,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  child: Stack(
                                    children: [
                                      ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 15.0,
                                            sigmaY: 15.0,
                                            tileMode: TileMode.decal),
                                        child: BarcodeWidget(
                                          data: 'Already Scanned',
                                          barcode: Barcode.qrCode(),
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.6,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.5,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          backgroundColor: Colors.transparent,
                                          errorBuilder: (context, error) =>
                                              SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.6,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.5,
                                          ),
                                          drawText: false,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Transform.rotate(
                                          angle: -0.5,
                                          // Adjust the angle to get the desired diagonal text
                                          child: Center(
                                            child: Text(
                                              'Already Scanned',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                    Colors.red.withOpacity(0.8),
                                                fontSize: 40.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Show this QR Code',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                ),
                            minFontSize: 13.0,
                          ),
                          AutoSizeText(
                            ' when prompted',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                ),
                            minFontSize: 13.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
