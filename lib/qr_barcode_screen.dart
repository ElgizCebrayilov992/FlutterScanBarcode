import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class QRBarcodeScreen extends StatefulWidget {
  QRBarcodeScreen({Key key}) : super(key: key);

  @override
  _QrBarcodeState createState() => new _QrBarcodeState();
}

class _QrBarcodeState extends State<QRBarcodeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode mFocusNodeQrValue = FocusNode();
  TextEditingController qrController = new TextEditingController();
  PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "www.developerlibs.com";
  final TextEditingController _textController = TextEditingController();
  String _qrInfo = 'Scan a QR/Bar code';
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: SafeArea(child: _buildScan(context)),
    );
  }

  @override
  void dispose() {
    mFocusNodeQrValue.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  _qrCallback(String code) {
    setState(() {
      if (!list.contains(code)) {
        list.add(code);
      }

      _qrInfo = code;
    });
  }

  Widget _buildScan(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          margin: const EdgeInsets.only(bottom: 10),
          child: QRBarScannerCamera(
            onError: (context, error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) {
              _qrCallback(code);
            },
          ),
        ),
        Text(
          _qrInfo,
          style: TextStyle(color: Colors.black26),
        ),
        list == null
            ? Text("Salam")
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: list.map((e) {
                      return Text(e);
                    }).toList(),
                  ),
                ),
                height: 200,
                width: 200,
              )
      ],
    );
  }
}
