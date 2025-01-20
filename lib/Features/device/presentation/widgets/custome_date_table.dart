import 'package:flutter/material.dart';
import 'package:bug_away/Core/utils/colors.dart';
import '../../data/models/testing_data_table.dart';

class CustomeDateTable extends StatelessWidget {
  final List<DeviceId> data;

  const CustomeDateTable({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: createColumns(),
        rows: createRow(),
      ),
    );
  }

  List<DataColumn> createColumns() {
    return [
      const DataColumn(label: Text('DeviceID')),
      const DataColumn(label: Text('Date')),
      const DataColumn(label: Text('Time')),
    ];
  }

  List<DataRow> createRow() {
    return data.map((e) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              e.id.toString(),
              style: const TextStyle(color: ColorManager.whiteColor),
            ),
          ),
          DataCell(
            Text(
              e.date.toString(),
              style: const TextStyle(color: ColorManager.whiteColor),
            ),
          ),
          DataCell(
            Text(
              e.time.toString(),
              style: const TextStyle(color: ColorManager.whiteColor),
            ),
          ),
        ],
      );
    }).toList();
  }
}
