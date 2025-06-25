
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletService {
  final String userId;

  WalletService(this.userId);

  /// 내부적으로만 포인트→코인 전환 또는 NFT 발급 등을 처리 (UI 비노출)
  Future<void> initializeWalletIfNotExists() async {
    final doc = FirebaseFirestore.instance.collection('wallets').doc(userId);
    final snapshot = await doc.get();
    if (!snapshot.exists) {
      await doc.set({
        'points': 0,
        'createdAt': Timestamp.now(),
        'nftLinked': false,
      });
    }
  }

  Future<void> addPoints(int amount) async {
    final doc = FirebaseFirestore.instance.collection('wallets').doc(userId);
    await doc.update({
      'points': FieldValue.increment(amount),
    });
  }

  Future<void> markNFTLinked() async {
    final doc = FirebaseFirestore.instance.collection('wallets').doc(userId);
    await doc.update({'nftLinked': true});
  }

  /// 필요시 자동화 스크립트 또는 관리자 페이지에서 이 정보 사용
}
