
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCertPage extends StatefulWidget {
  const AdminCertPage({super.key});

  @override
  State<AdminCertPage> createState() => _AdminCertPageState();
}

class _AdminCertPageState extends State<AdminCertPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Stream<QuerySnapshot> _getCertifications(String type) {
    return FirebaseFirestore.instance
        .collection('certifications')
        .where('type', isEqualTo: type)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Widget _buildList(String type) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getCertifications(type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('기록이 없습니다.'));
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final amount = data['amount'] ?? 0;
            final imageUrl = data['imageUrl'] ?? '';
            final userId = data['userId'] ?? '';
            final timestamp = (data['timestamp'] as Timestamp).toDate();

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: imageUrl.isNotEmpty
                    ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.receipt),
                title: Text('₩$amount - $userId'),
                subtitle: Text('날짜: ${timestamp.toLocal()}'),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('관리자 인증 확인'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: '정비'),
              Tab(text: '세차'),
              Tab(text: '주유'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildList('repair'),
            _buildList('wash'),
            _buildList('gas'),
          ],
        ),
      ),
    );
  }
}
