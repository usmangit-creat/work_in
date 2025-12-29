import 'package:flutter/material.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  bool _isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Hello, Worker 👋", style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          Text("Electrician", style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey)),
        ]),
        actions: [
          Switch(value: _isOnline, activeColor: Colors.green, onChanged: (val) => setState(() => _isOnline = val)),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Earnings Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF2C43A8), borderRadius: BorderRadius.circular(16)),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Total Earnings", style: TextStyle(fontFamily: 'Poppins', color: Colors.white70)),
                SizedBox(height: 5),
                Text("PKR 15,400", style: TextStyle(fontFamily: 'Poppins', fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              ]),
            ),
            const SizedBox(height: 20),
            const Align(alignment: Alignment.centerLeft, child: Text("New Jobs", style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 10),
            // Job Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                const Row(children: [
                  Icon(Icons.person), SizedBox(width: 10),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Ali Khan", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                    Text("Johar Town, Lahore", style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey)),
                  ]),
                  Spacer(),
                  Text("PKR 800", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Color(0xFF2C43A8))),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Decline"))),
                  const SizedBox(width: 10),
                  Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C43A8)), child: const Text("Accept", style: TextStyle(color: Colors.white)))),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}