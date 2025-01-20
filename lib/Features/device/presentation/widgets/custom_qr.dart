import 'package:bug_away/Core/utils/colors.dart';
import 'package:bug_away/Core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomQRScanner extends StatefulWidget {
  const CustomQRScanner({super.key});

  @override
  CustomQRScannerState createState() => CustomQRScannerState();
}

class CustomQRScannerState extends State<CustomQRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;
  bool isFlashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.deviceScan),
        backgroundColor: ColorManager.backgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: ColorManager.whiteColor,
              borderRadius: 12,
              borderLength: 38,
              borderWidth: 12,
              cutOutSize: 260,
              cutOutBottomOffset: 50,
              overlayColor:
                  ColorManager.blackColor.withAlpha((0.5 * 255).toInt()),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                icon: FaIcon(
                  isFlashOn
                      ? FontAwesomeIcons.solidLightbulb
                      : FontAwesomeIcons.lightbulb,
                  color: ColorManager.whiteColor,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                  });
                  controller?.toggleFlash();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code;
      });
      controller.pauseCamera();
      Future.delayed(const Duration(milliseconds: 300), () {
        // ignore: use_build_context_synchronously
        Navigator.pop(context, qrText);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
