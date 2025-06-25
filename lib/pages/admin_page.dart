import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String filterUid = '';

  @override
  Widget build(BuildContext context) {
    final query = filterUid.isEmpty
        ? FirebaseFirestore.instance.collectionGroup('certifications').orderBy('timestamp', descending: true)
        : FirebaseFirestore.instance
            .collectionGroup('certifications')
            .where('uid', isEqualTo: filterUid)
            .orderBy('timestamp', descending: true);

    return Scaffold(
      appBar: AppBar(title: const Text('관리자 인증 모니터링')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'UID 필터 (선택)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filterUid = value.trim();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: query.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) return const Center(child: Text('인증 기록 없음'));

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final type = data['type'] ?? '기록';
                    final amount = data['amount'] ?? '-';
                    final uid = data['uid'] ?? 'Unknown';
                    final timestamp = (data['timestamp'] as Timestamp).toDate();

                    return ListTile(
                      leading: const Icon(Icons.verified_user),
                      title: Text('$type - ${amount}원'),
                      subtitle: Text('UID: $uid\n${timestamp.toLocal()}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
