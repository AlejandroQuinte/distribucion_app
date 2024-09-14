import 'package:distribucion_app/domain/entities/client.dart';

class ClientModel {
  String? idClient;
  String name;
  int code;

  ClientModel({this.idClient, required this.name, required this.code});

  Map<String, dynamic> toJson() {
    return {
      'idClient': idClient,
      'name': name,
      'code': code,
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      idClient: json['idClient'],
      name: json['name'],
      code: json['code'],
    );
  }

  factory ClientModel.fromEntity(Client client) {
    return ClientModel(
      idClient: client.idClient,
      name: client.name,
      code: client.code,
    );
  }

  // toEntity
  Client toEntity() {
    return Client(
      idClient: idClient,
      name: name,
      code: code,
    );
  }
}
