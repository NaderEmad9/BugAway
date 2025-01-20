// ignore_for_file: use_build_context_synchronously

import 'package:bug_away/Core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../../../../Core/utils/colors.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: ColorManager.blackColor,
    exportBackgroundColor: ColorManager.whiteColor,
  );

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.signaturePad),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 20, bottom: 60),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Signature(
                      controller: signatureController,
                      backgroundColor: ColorManager.whiteColor,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: FloatingActionButton(
              heroTag: 'clearButton',
              onPressed: () {
                signatureController.clear();
                setState(() {});
              },
              backgroundColor: ColorManager.primaryColor,
              child: const Icon(Icons.clear, color: ColorManager.whiteColor),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 30,
            child: FloatingActionButton(
              heroTag: 'checkButton',
              onPressed: () async {
                if (signatureController.isNotEmpty) {
                  var data = await signatureController.toPngBytes();
                  if (data != null) {
                    Navigator.pop(context, data);
                  }
                }
              },
              backgroundColor: ColorManager.primaryColor,
              child: const Icon(Icons.check, color: ColorManager.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
