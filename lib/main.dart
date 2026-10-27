import 'package:flutter/material.dart';

void main() => runApp(const KDPartyApp());

const bg = Color(0xFF10051D);
const panel = Color(0xFF1B1028);
const stroke = Color(0xFF49305D);
const pink = Color(0xFFEC3C91);
const purple = Color(0xFF6825A0);
const muted = Color(0xFFB9A9C8);

class KDPartyApp extends StatelessWidget {
  const KDPartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KD Party',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: pink, brightness: Brightness.dark),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}

class Room {
  final String name, host, people, emoji;
  const Room(this.name, this.host, this.people, this.emoji);
}

const rooms = [
  Room('Happy Chat Room', 'Maya Queen', '128', '🎉'),
  Room('Bangla Adda', 'KD Host', '86', '🌸'),
  Room('Music Lovers', 'Music Star', '64', '🎵'),
  Room('Night Hangout', 'KD Admin', '42', '🌙'),
  Room('Friends Zone', 'Party Host', '35', '💜'),
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;
  int coins = 1000;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(coins: coins, onTab: (v) => setState(() => tab = v), onJoin: openRoom),
      RoomsPage(onJoin: openRoom),
      GiftsPage(onSend: (cost) {
        if (coins >= cost) {
          setState(() => coins -= cost);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('গিফট পাঠানো হয়েছে • $cost কয়েন')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('পর্যাপ্ত কয়েন নেই')));
        }
      }),
      WalletPage(coins: coins),
      const ProfilePage(),
    ];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: tab, children: pages)),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF170A25),
        indicatorColor: purple.withOpacity(.35),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Text('🏠', style: TextStyle(fontSize: 22)), label: 'হোম'),
          NavigationDestination(icon: Text('🎙️', style: TextStyle(fontSize: 22)), label: 'রুম'),
          NavigationDestination(icon: Text('🎁', style: TextStyle(fontSize: 22)), label: 'গিফট'),
          NavigationDestination(icon: Text('🪙', style: TextStyle(fontSize: 22)), label: 'ওয়ালেট'),
          NavigationDestination(icon: Text('🙋', style: TextStyle(fontSize: 22)), label: 'প্রোফাইল'),
        ],
      ),
    );
  }

  void openRoom(Room room) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => RoomDetailPage(room: room)));
  }
}

class HomePage extends StatelessWidget {
  final int coins;
  final ValueChanged<int> onTab;
  final ValueChanged<Room> onJoin;
  const HomePage({super.key, required this.coins, required this.onTab, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      children: [
        Row(children: [
          const Text('👑', style: TextStyle(fontSize: 34)),
          const SizedBox(width: 8),
          const Expanded(child: Text('KD Party', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900, color: Color(0xFFFF8A9E)))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(color: panel, border: Border.all(color: stroke), borderRadius: BorderRadius.circular(30)),
            child: Text('🪙 $coins কয়েন', style: const TextStyle(fontWeight: FontWeight.bold)),
          )
        ]),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(colors: [Color(0xFF9A1C91), Color(0xFF51206F)]),
            border: Border.all(color: const Color(0xFF9B50B7)),
          ),
          child: Row(children: [
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('🎙️ কথা বলুন, বন্ধু বানান', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('আপনার পার্টি শুরু হোক আজই', style: TextStyle(color: Colors.white70)),
            ])),
            const Text('👑', style: TextStyle(fontSize: 56)),
          ]),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFFFB45F), foregroundColor: bg, padding: const EdgeInsets.symmetric(vertical: 15)),
            onPressed: () => onTab(1), child: const Text('🎙️ রুমে যান', style: TextStyle(fontWeight: FontWeight.bold)),
          )),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: stroke), padding: const EdgeInsets.symmetric(vertical: 15)),
            onPressed: () => onTab(2), child: const Text('👑 VIP দেখুন', style: TextStyle(fontWeight: FontWeight.bold)),
          )),
        ]),
        const SizedBox(height: 28),
        const SectionHeading(title: 'শর্টকাট', subtitle: 'আপনার পার্টি স্পেস'),
        const SizedBox(height: 12),
        Row(children: [
          Shortcut(icon: '🎙️', label: 'ভয়েস রুম', onTap: () => onTab(1)),
          Shortcut(icon: '🎁', label: 'গিফট', onTap: () => onTab(2)),
          Shortcut(icon: '👑', label: 'VIP লেভেল', onTap: () => onTab(2)),
          Shortcut(icon: '🙋', label: 'প্রোফাইল', onTap: () => onTab(4)),
        ]),
        const SizedBox(height: 28),
        const SectionHeading(title: 'জনপ্রিয় রুম', subtitle: 'ডেমো তালিকা'),
        const SizedBox(height: 12),
        ...rooms.take(3).map((r) => RoomCard(room: r, onJoin: () => onJoin(r))),
      ],
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title, subtitle;
  const SectionHeading({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900))),
    Text(subtitle, style: const TextStyle(color: muted)),
  ]);
}

class Shortcut extends StatelessWidget {
  final String icon, label;
  final VoidCallback onTap;
  const Shortcut({super.key, required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => Expanded(child: Padding(
    padding: const EdgeInsets.only(right: 7),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 104,
        decoration: BoxDecoration(color: panel, border: Border.all(color: stroke), borderRadius: BorderRadius.circular(22)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(icon, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ]),
      ),
    ),
  ));
}

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onJoin;
  const RoomCard({super.key, required this.room, required this.onJoin});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: panel, border: Border.all(color: stroke), borderRadius: BorderRadius.circular(24)),
    child: Row(children: [
      Container(width: 72, height: 72, alignment: Alignment.center, decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF8D28A7), Color(0xFFDE3298)]),
        borderRadius: BorderRadius.circular(20)), child: Text(room.emoji, style: const TextStyle(fontSize: 34))),
      const SizedBox(width: 13),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Flexible(child: Text(room.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
          const SizedBox(width: 6),
          Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: pink, borderRadius: BorderRadius.circular(10)), child: const Text('LIVE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        ]),
        const SizedBox(height: 6),
        Text('🎙️ ${room.host} · 👥 ${room.people} জন', style: const TextStyle(color: muted)),
      ])),
      const SizedBox(width: 7),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white),
        onPressed: onJoin, child: const Text('Join'),
      ),
    ]),
  );
}

class RoomsPage extends StatelessWidget {
  final ValueChanged<Room> onJoin;
  const RoomsPage({super.key, required this.onJoin});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('লাইভ পার্টি রুম', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8),
    const Text('একটি রুম বেছে নিয়ে প্রবেশ করুন।', style: TextStyle(color: muted)),
    const SizedBox(height: 18),
    ...rooms.map((r) => RoomCard(room: r, onJoin: () => onJoin(r))),
  ]);
}

class RoomDetailPage extends StatefulWidget {
  final Room room;
  const RoomDetailPage({super.key, required this.room});
  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}
class _RoomDetailPageState extends State<RoomDetailPage> {
  final controller = TextEditingController();
  final messages = <String>['KD Host: সবাইকে স্বাগতম! 🎉', 'Maya Queen: কেমন আছেন সবাই?'];
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.room.name), backgroundColor: bg),
    body: Column(children: [
      Container(width: double.infinity, padding: const EdgeInsets.all(24), color: panel, child: Column(children: [
        Text(widget.room.emoji, style: const TextStyle(fontSize: 64)),
        const SizedBox(height: 8),
        Text(widget.room.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        Text('🎙️ ${widget.room.host} · 👥 ${widget.room.people} জন', style: const TextStyle(color: muted)),
        const SizedBox(height: 16),
        Wrap(spacing: 12, children: [
          FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('লাইভ ভয়েসের জন্য সার্ভার সংযোগ প্রয়োজন।'))), child: const Text('🎙️ মাইক')),
          OutlinedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('গিফট ফিচার ডেমো মোডে আছে।'))), child: const Text('🎁 গিফট')),
        ]),
      ])),
      Expanded(child: ListView(padding: const EdgeInsets.all(16), children: messages.map((m) => Container(
        margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(14)), child: Text(m),
      )).toList()),
      ),
      SafeArea(top: false, child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
        Expanded(child: TextField(controller: controller, decoration: InputDecoration(hintText: 'মেসেজ লিখুন...', filled: true, fillColor: panel, border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none)))),
        const SizedBox(width: 8),
        IconButton.filled(onPressed: () { if (controller.text.trim().isNotEmpty) { setState(() { messages.add('আপনি: ${controller.text.trim()}'); controller.clear(); }); } }, icon: const Icon(Icons.send)),
      ]))),
    ]),
  );
}

class GiftsPage extends StatelessWidget {
  final ValueChanged<int> onSend;
  const GiftsPage({super.key, required this.onSend});
  @override
  Widget build(BuildContext context) {
    const gifts = [('🌹', 'গোলাপ', 10), ('💖', 'হার্ট', 50), ('🎂', 'কেক', 100), ('🚗', 'কার', 500), ('👑', 'ক্রাউন', 800), ('🎉', 'পার্টি', 150)];
    return ListView(padding: const EdgeInsets.all(18), children: [
      const Text('গিফট শপ', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
      const SizedBox(height: 8),
      const Text('ডেমো গিফট বেছে নিন', style: TextStyle(color: muted)),
      const SizedBox(height: 18),
      GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.05,
        children: gifts.map((g) => Container(decoration: BoxDecoration(color: panel, border: Border.all(color: stroke), borderRadius: BorderRadius.circular(22)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(g.$1, style: const TextStyle(fontSize: 42)),
          Text(g.$2, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('🪙 ${g.$3}', style: const TextStyle(color: muted)),
          const SizedBox(height: 8),
          FilledButton(onPressed: () => onSend(g.$3), child: const Text('পাঠান')),
        ]))).toList(),
      ),
      const SizedBox(height: 18),
      const Text('নোট: বাস্তব কয়েন কেনা/পেমেন্ট যুক্ত করা হয়নি।', style: TextStyle(color: muted)),
    ]);
  }
}

class WalletPage extends StatelessWidget {
  final int coins;
  const WalletPage({super.key, required this.coins});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('আমার ওয়ালেট', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF8D28A7), Color(0xFF4C207D)]), borderRadius: BorderRadius.circular(25)), child: Column(children: [
      const Text('মোট কয়েন', style: TextStyle(color: Colors.white70)),
      const SizedBox(height: 8),
      Text('🪙 $coins', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900)),
    ])),
    const SizedBox(height: 18),
    const ListTile(leading: Icon(Icons.history), title: Text('লেনদেনের ইতিহাস'), subtitle: Text('এখনও কোনো বাস্তব লেনদেন নেই')),
    const ListTile(leading: Icon(Icons.info_outline), title: Text('পেমেন্ট সেটআপ'), subtitle: Text('পেমেন্ট গেটওয়ে সংযুক্ত করা বাকি')),
  ]);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('আমার প্রোফাইল', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
    const SizedBox(height: 24),
    const CircleAvatar(radius: 48, backgroundColor: purple, child: Text('🙋', style: TextStyle(fontSize: 46))),
    const SizedBox(height: 12),
    const Center(child: Text('KD Party User', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
    const Center(child: Text('ID: KD10001', style: TextStyle(color: muted))),
    const SizedBox(height: 24),
    const ListTile(leading: Icon(Icons.person_outline), title: Text('প্রোফাইল সম্পাদনা')),
    const ListTile(leading: Icon(Icons.verified_outlined), title: Text('VIP সদস্যতা'), subtitle: Text('VIP পেমেন্ট সংযোগ করা হয়নি')),
    const ListTile(leading: Icon(Icons.settings_outlined), title: Text('সেটিংস')),
    const ListTile(leading: Icon(Icons.help_outline), title: Text('সাহায্য ও সাপোর্ট')),
    const SizedBox(height: 12),
    const Text('এটি UI starter: লগইন, ডেটাবেস, লাইভ অডিও ও পেমেন্টের জন্য ব্যাকএন্ড প্রয়োজন।', style: TextStyle(color: muted)),
  ]);
}
