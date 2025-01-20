import 'package:bug_away/Features/device/presentation/widgets/custom_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bug_away/Config/routes/routes_manger.dart';
import 'package:bug_away/Core/component/button_custom.dart';
import 'package:bug_away/Core/utils/colors.dart';
import 'package:bug_away/Core/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bug_away/Features/site_report/presentation/manager/report_view_model.dart';
import 'package:intl/intl.dart';
import '../../data/models/testing_data_table.dart';
import '../widgets/custome_date_table.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen>
    with SingleTickerProviderStateMixin {
  String code = 'Unknown';
  double _opacity = 0.0;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  List<DeviceId> scannedDevices = [];

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _slideAnimation =
        Tween<Offset>(begin: Offset(-1.w, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportViewModel = context.read<ReportViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.device),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: ColorManager.whiteColor),
            onPressed: () {
              reportViewModel.updateDevices([code]);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SlideTransition(
                position: _slideAnimation,
                child: ButtonCustom(
                    buttonName: StringManager.newScan, onTap: scan)),
            SizedBox(height: 20.h),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              child: Text(
                StringManager.deviceLastScan,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(color: ColorManager.primaryColor),
            // Data Table
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: CustomeDateTable(data: scannedDevices),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scan() async {
    final scanCode = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CustomQRScanner()),
    );

    if (scanCode != null && scanCode is String) {
      setState(() {
        code = scanCode;
        scannedDevices.add(DeviceId(
          id: scanCode,
          date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
          time: DateFormat('HH:mm').format(DateTime.now()),
        ));
      });

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(
          RoutesManger.routeNameDeviceInspectionScreen,
          arguments: code);
    }
  }
}
