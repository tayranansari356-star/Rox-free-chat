import 'package:flutter/material.dart';

void main() => runApp(const RoxFreeChat());

class RoxFreeChat extends StatelessWidget {
  const RoxFreeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rox Free Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.forum_rounded, size: 76),
              const SizedBox(height: 16),
              const Text('Rox Free Chat',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Chat freely. Connect easily.'),
              const SizedBox(height: 32),
              const TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const HomePage())),
                  child: const Text('Login'),
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Create account')),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final pages = const [ChatsPage(), ContactsPage(), ProfilePage(), AdminPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rox Free Chat')),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chats'),
          NavigationDestination(icon: Icon(Icons.people_outline), label: 'People'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.admin_panel_settings_outlined), label: 'Admin'),
        ],
      ),
    );
  }
}

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final chats = ['Ayaan', 'Sara', 'Imran', 'Zoya'];
    return ListView(
      children: chats.map((name) => ListTile(
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: const Text('Tap to open chat'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => ChatPage(name: name))),
      )).toList(),
    );
  }
}

class ChatPage extends StatelessWidget {
  final String name;
  const ChatPage({super.key, required this.name});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(name)),
    body: Column(children: [
      const Expanded(child: Center(child: Text('Your messages will appear here.'))),
      SafeArea(child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          const Expanded(child: TextField(decoration: InputDecoration(
            hintText: 'Write a message...', border: OutlineInputBorder()))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
        ]),
      )),
    ]),
  );
}

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: Text('Find people, search users and start a new chat.'),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: const [
      CircleAvatar(radius: 45, child: Icon(Icons.person, size: 48)),
      SizedBox(height: 16),
      Center(child: Text('My Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      ListTile(leading: Icon(Icons.edit), title: Text('Edit profile')),
      ListTile(leading: Icon(Icons.notifications), title: Text('Notifications')),
      ListTile(leading: Icon(Icons.lock), title: Text('Privacy & Security')),
    ],
  );
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text('Admin Dashboard', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      _card('Users', 'Manage accounts, bans and permissions', Icons.people),
      _card('Reports', 'Review reported messages and users', Icons.flag),
      _card('Content', 'Control public content and moderation', Icons.dashboard),
      _card('App Settings', 'Control notifications, limits and features', Icons.settings),
      _card('Analytics', 'View users, activity and growth', Icons.analytics),
    ],
  );

  Widget _card(String title, String subtitle, IconData icon) => Card(
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
  );
}
