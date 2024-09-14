class Client {
  String? idClient;
  String name;
  int code;

  Client({this.idClient, required this.name, required this.code});

  // copyWith
  Client copyWith({
    String? idClient,
    String? name,
    int? code,
  }) {
    return Client(
      idClient: idClient ?? this.idClient,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}
