enum StatusAsset { operating, alert }

class Asset {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final StatusAsset? status;
  final String? gatewayId;
  final String? locationId;
  final bool isLocation;

  const Asset({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
    required this.isLocation,
  });

  factory Asset.fromMap(
          {required Map<String, dynamic> map, required bool isLocation}) =>
      Asset(
        id: map['id'],
        name: map['name'],
        parentId: map['parentId'],
        sensorId: map['sensorId'],
        sensorType: map['sensorType'],
        status: StatusAsset.values.cast().firstWhere(
            (e) =>
                e.name.toLowerCase() == map['status'].toString().toLowerCase(),
            orElse: () => null),
        gatewayId: map['gatewayId'],
        locationId: map['locationId'],
        isLocation: isLocation,
      );

  bool get isComponent => sensorType != null;

  bool get isRoot =>
      parentId == null &&
      sensorId == null &&
      sensorType == null &&
      status == null &&
      gatewayId == null &&
      locationId == null;
}
