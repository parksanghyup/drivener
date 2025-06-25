import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// User profile & point info
class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "points" field.
  double? _points;
  double get points => _points ?? 0.0;
  bool hasPoints() => _points != null;

  // "total_distance" field.
  double? _totalDistance;
  double get totalDistance => _totalDistance ?? 0.0;
  bool hasTotalDistance() => _totalDistance != null;

  // "vehicle_id" field.
  String? _vehicleId;
  String get vehicleId => _vehicleId ?? '';
  bool hasVehicleId() => _vehicleId != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "referrer_uid" field.
  String? _referrerUid;
  String get referrerUid => _referrerUid ?? '';
  bool hasReferrerUid() => _referrerUid != null;

  // "booster_active" field.
  bool? _boosterActive;
  bool get boosterActive => _boosterActive ?? false;
  bool hasBoosterActive() => _boosterActive != null;

  // "uid_type" field.
  String? _uidType;
  String get uidType => _uidType ?? '';
  bool hasUidType() => _uidType != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _points = castToType<double>(snapshotData['points']);
    _totalDistance = castToType<double>(snapshotData['total_distance']);
    _vehicleId = snapshotData['vehicle_id'] as String?;
    _rating = castToType<double>(snapshotData['rating']);
    _referrerUid = snapshotData['referrer_uid'] as String?;
    _boosterActive = snapshotData['booster_active'] as bool?;
    _uidType = snapshotData['uid_type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  double? points,
  double? totalDistance,
  String? vehicleId,
  double? rating,
  String? referrerUid,
  bool? boosterActive,
  String? uidType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'points': points,
      'total_distance': totalDistance,
      'vehicle_id': vehicleId,
      'rating': rating,
      'referrer_uid': referrerUid,
      'booster_active': boosterActive,
      'uid_type': uidType,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.points == e2?.points &&
        e1?.totalDistance == e2?.totalDistance &&
        e1?.vehicleId == e2?.vehicleId &&
        e1?.rating == e2?.rating &&
        e1?.referrerUid == e2?.referrerUid &&
        e1?.boosterActive == e2?.boosterActive &&
        e1?.uidType == e2?.uidType;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.points,
        e?.totalDistance,
        e?.vehicleId,
        e?.rating,
        e?.referrerUid,
        e?.boosterActive,
        e?.uidType
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
