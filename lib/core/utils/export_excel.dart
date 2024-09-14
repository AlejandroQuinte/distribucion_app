import 'dart:io';
import 'package:distribucion_app/domain/entities/distribution.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> exportToExcel(List<Distribution> distributions, context) async {
  // Crear un libro de Excel
  final excel = Excel.createExcel();

  // Crear una hoja de cálculo
  final sheet = excel['Distributions'];

  // Agregar encabezados
  final headers = [
    'ID',
    'Date',
    'Client Name',
    'Client Code',
    'ID Client',
    'Cartons',
    'Discounts',
    'Type Pay',
    'Observations',
  ];
  CellStyle cellStyle = CellStyle(
      backgroundColorHex: ExcelColor.amber,
      fontFamily: getFontFamily(FontFamily.Calibri));

  cellStyle.underline = Underline.Single; // or Underline.Double

  var cell = sheet.cell(CellIndex.indexByString('A1'));
  cell.value = null; // removing any value
  cell.value = TextCellValue('Some Text');
  cell.cellStyle = cellStyle;
  sheet.appendRow(headers.map((header) => TextCellValue(header)).toList());

  // Agregar datos de distribución
  for (final distribution in distributions) {
    final rowData = [
      distribution.id,
      distribution.date.toIso8601String(),
      distribution.clientName,
      distribution.clientCode,
      distribution.idClient,
      distribution.cartons,
      distribution.discounts,
      distribution.typePay,
      distribution.observations,
    ];
  }

  try {
    // Obtener la ruta de destino del usuario
    // final downloadsDirectory = await getExternalStorageDirectory();
    // if (downloadsDirectory == null) {
    //   print('No se pudo obtener el directorio de descargas.');
    //   return;
    // }

    // final date = distributions.isNotEmpty
    //     ? DateFormat('yyyy-MM-dd').format(distributions[0].date)
    //     : DateFormat('yyyy-MM-dd').format(DateTime.now());

    // final directory = await downloadsDirectory.create(recursive: true);
    // final excelFile = '${directory.path}/distributions-$date.xlsx';

    // final file = File(excelFile);
    // final bytes = excel.encode();
    // await file.writeAsBytes(bytes!);

    // _getLocation(context);
    return;
    // Obtener la ruta de destino del usuario
    String downloadsDirectory = getDownloadDirectory();

    final date = distributions.isNotEmpty
        ? DateFormat('yyyy-MM-dd').format(distributions[0].date)
        : DateFormat('yyyy-MM-dd').format(DateTime.now());

    final excelFile = '$downloadsDirectory/distributions-$date.xlsx';

    final file = File(excelFile);
    final bytes = excel.encode();
    await file.writeAsBytes(bytes!);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Archivo exportado'),
          content: Text('El archivo se ha guardado en: $excelFile'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print(e);
  }
}

Future<void> checkAndRequestPermissions(
    List<Distribution> distributions, context) async {
  // await exportToExcel(distributions);
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }

  if (status.isGranted) {
    await exportToExcel(distributions, context);
  } else {
    print('Permission denied');
  }
}

String getIOSDownloadDirectory() {
  if (Platform.isIOS) {
    return '${Directory.systemTemp.path}/Downloads';
  } else {
    // Si no es un dispositivo iOS, devuelve una cadena vacía
    return '';
  }
}

String getAndroidDownloadDirectory() {
  if (Platform.isAndroid) {
    return '/storage/emulated/0/Download';
  } else {
    // Si no es un dispositivo Android, devuelve una cadena vacía
    return '';
  }
}

String getDownloadDirectory() {
  if (Platform.isAndroid) {
    return getAndroidDownloadDirectory();
  } else if (Platform.isIOS) {
    return getIOSDownloadDirectory();
  } else {
    // Si no es ni Android ni iOS, devuelve una cadena vacía
    return '';
  }
}
