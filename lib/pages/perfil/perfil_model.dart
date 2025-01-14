import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_util.dart';
import './perfil_widget.dart' show PerfilWidget;

class PerfilModel extends FlutterFlowModel<PerfilWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
