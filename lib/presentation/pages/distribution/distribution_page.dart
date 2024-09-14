import 'dart:async';

import 'package:distribucion_app/domain/entities/distribution.dart';
import 'package:distribucion_app/presentation/blocs/distribution_bloc/distribution_bloc.dart';
import 'package:distribucion_app/data/repositories/db_local_repository.dart';
import 'package:distribucion_app/core/utils/export_excel.dart';
import 'package:distribucion_app/core/utils/tranform_distribution.dart';
import 'package:distribucion_app/presentation/widgets/loading_overlay.dart';
import 'package:distribucion_app/presentation/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DistributionPage extends StatelessWidget {
  const DistributionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dBloc = context.read<DistributionBloc>();
    const List<String> listTP = <String>['Ticket', 'Factura'];

    final size = MediaQuery.of(context).size;
    ScrollController scrollController = ScrollController();
    onTap() {}

    return Scaffold(
      drawer: const SideBar(),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: BlocBuilder<DistributionBloc, DistributionState>(
            bloc: dBloc,
            buildWhen: (previous, current) {
              return previous.date != current.date;
            },
            builder: (context, state) {
              return Text(
                  'Fecha: ${DateFormat('yyyy-MM-dd').format(state.date)}');
            }),
      ),
      body: Column(
        children: [
          CustomBtn(dBloc: dBloc),
          BlocBuilder<DistributionBloc, DistributionState>(
            buildWhen: (previous, current) {
              return previous.isLoading != current.isLoading;
            },
            builder: (context, state) {
              final distributions = state.distributions;

              if (state.isLoading) {
                return SizedBox(
                  height: size.height * 0.75,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: size.height * 0.75,
                  width: size.width * 2.5,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return DataTable(
                        columns: const [
                          DataColumn(label: Text('Cliente')),
                          DataColumn(label: Text('Codigos')),
                          DataColumn(label: Text('Cartones')),
                          DataColumn(label: Text('Descuentos')),
                          DataColumn(label: Text('Tipo de Pago')),
                          DataColumn(label: Text('Observaciones')),
                        ],
                        rows: distributions
                            .map((d) => cellDataRow(d, dBloc, listTP, onTap))
                            .toList(),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  DataRow cellDataRow(
    Distribution d,
    DistributionBloc dBloc,
    List<String> listTP,
    Function onTap,
  ) {
    final isZeroVal = d.cartons == 0 ? Colors.red : Colors.blue;

    return DataRow(
      cells: [
        DataCell(Text(d.clientName)),
        DataCell(Text(d.clientCode.toString())),
        DataCell(
          TextFormField(
            initialValue: d.cartons.toString(),
            style: TextStyle(color: isZeroVal),
            onTap: () => onTap(),
            onChanged: (newValue) {
              if (newValue.isNotEmpty) {
                final changed = d.copyWith(cartons: int.parse(newValue));
                dBloc.add(UpdateDistribution(updatedDistribution: changed));
              }
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        DataCell(
          TextFormField(
            initialValue: d.discounts.toString(),
            style: TextStyle(color: isZeroVal),
            onChanged: (newValue) {
              if (newValue.isNotEmpty) {
                d = d.copyWith(discounts: int.parse(newValue));
                dBloc.add(UpdateDistribution(updatedDistribution: d));
              }
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        DataCell(
          DropdownButton<String>(
            value: d.typePay,
            icon: const Icon(Icons.arrow_drop_down),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              d = d.copyWith(typePay: value);
              dBloc.add(UpdateDistribution(updatedDistribution: d));
            },
            items: listTP.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ),
        DataCell(
          TextFormField(
            initialValue: d.observations.toString(),
            style: TextStyle(color: isZeroVal),
            onChanged: (newValue) {
              d = d.copyWith(observations: newValue);
              dBloc.add(UpdateDistribution(updatedDistribution: d));
            },
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.dBloc});

  final DistributionBloc dBloc;

  @override
  Widget build(BuildContext context) {
    final clients = dBloc.state.clients;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await checkAndRequestPermissions(
                        dBloc.state.distributions, context);
                  },
                  child: const Text(
                    'Exportar a Excel',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    LocalDatabaseRepository.db
                        .newDistribution(dBloc.state.distributions)
                        .then(
                      (value) {
                        if (value > 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Distribucion guardada correctamente'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al guardar la distribucion'),
                            ),
                          );
                        }
                      },
                    );
                  },
                  child: const Text(
                    'Guardar distribucion',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final date =
                    await _selectDate(context, dBloc.state.date).then((value) {
                  LoadingOverlay.show(context);
                  return value;
                });

                if (date == dBloc.state.date) {
                  LoadingOverlay.hide();
                  return;
                }

                dBloc.add(IsLoading(true));

                dBloc.add(SetDate(date));
                await LocalDatabaseRepository.db
                    .getAllDistributionByDate(date)
                    .then(
                  (value) {
                    getLocalDistribution(clients, value, dBloc, date);

                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        dBloc.add(IsLoading(false));
                      },
                    );

                    LoadingOverlay.hide();
                  },
                );
              },
              child: const Text('Seleccionar Fecha'),
            ),
          ],
        ),
      ],
    );
  }
}

Future<DateTime> _selectDate(BuildContext context, DateTime date) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: date, // Fecha inicial
    firstDate: DateTime(2015, 8), // Fecha mínima seleccionable
    lastDate: DateTime(2101), // Fecha máxima seleccionable
  );

  return picked ?? date;
}
