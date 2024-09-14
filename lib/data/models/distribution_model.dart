import 'package:distribucion_app/domain/entities/distribution.dart';
import 'package:intl/intl.dart';

class DistributionModel {
  final String id;
  final DateTime date;
  final String clientName;
  final int clientCode;
  String? idClient;
  final int cartons;
  final int discounts;
  final String typePay;
  final String observations;

  DistributionModel({
    required this.id,
    required this.date,
    required this.clientName,
    required this.clientCode,
    idClient,
    required this.cartons,
    required this.discounts,
    required this.typePay,
    required this.observations,
  });

  DistributionModel updateValues({
    String? idClient,
    int? cartons,
    int? discounts,
    String? typePay,
    String? observations,
  }) {
    return DistributionModel(
      id: id,
      date: date,
      clientName: clientName,
      clientCode: clientCode,
      idClient: idClient ?? this.idClient,
      cartons: cartons ?? this.cartons,
      discounts: discounts ?? this.discounts,
      typePay: typePay ?? this.typePay,
      observations: observations ?? this.observations,
    );
  }

  // Método para convertir el modelo en una entidad
  Distribution toEntity() {
    return Distribution(
      id: id,
      date: date,
      clientName: clientName,
      clientCode: clientCode,
      idClient: idClient,
      cartons: cartons,
      discounts: discounts,
      typePay: typePay,
      observations: observations,
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'clientName': clientName,
      'clientCode': clientCode,
      'idClient': idClient,
      'cartons': cartons,
      'discounts': discounts,
      'typePay': typePay,
      'observations': observations,
    };
  }

  factory DistributionModel.fromJson(Map<String, dynamic> json) {
    return DistributionModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      clientName: json['clientName'],
      clientCode: json['clientCode'],
      idClient: json['idClient'],
      cartons: json['cartons'],
      discounts: json['discounts'],
      typePay: json['typePay'],
      observations: json['observations'],
    );
  }
}

class TotalDistributionModel {
  final String idDistribution;
  final int warehouseExit;
  final int total;
  final int availableRoute;
  final int difference;
  final int disposal;

  TotalDistributionModel({
    required this.idDistribution,
    required this.warehouseExit,
    required this.total,
    required this.availableRoute,
    required this.difference,
    required this.disposal,
  });

  Map<String, dynamic> toJson() {
    return {
      'idDistribution': idDistribution,
      'warehouseExit': warehouseExit,
      'total': total,
      'availableRoute': availableRoute,
      'difference': difference,
      'disposal': disposal,
    };
  }

  factory TotalDistributionModel.fromJson(Map<String, dynamic> json) {
    return TotalDistributionModel(
      idDistribution: json['idDistribution'],
      warehouseExit: json['warehouseExit'],
      total: json['total'],
      availableRoute: json['availableRoute'],
      difference: json['difference'],
      disposal: json['disposal'],
    );
  }
}
