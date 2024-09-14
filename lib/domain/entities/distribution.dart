class Distribution {
  final String id;
  final DateTime date;
  final String clientName;
  final int clientCode;
  String? idClient;
  final int cartons;
  final int discounts;
  final String typePay;
  final String observations;

  Distribution({
    required this.id,
    required this.date,
    required this.clientName,
    required this.clientCode,
    this.idClient,
    required this.cartons,
    required this.discounts,
    required this.typePay,
    required this.observations,
  });

  //copyWith
  Distribution copyWith({
    String? idClient,
    int? cartons,
    int? discounts,
    String? typePay,
    String? observations,
  }) {
    return Distribution(
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
}
