import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends StatefulWidget {
  const LocalStorage({super.key});

  @override
  State<LocalStorage> createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  bool isLoggedIn = false;
  bool darkMode = false;
  bool notifications = false;
  String username = "";

  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      darkMode = prefs.getBool('darkMode') ?? false;
      notifications = prefs.getBool('notifications') ?? false;
      username = prefs.getString('username') ?? "";
    });
  }

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("username", usernameController.text);

    setState(() {
      isLoggedIn = true;
      username = usernameController.text;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LocalStorage(),
      ),
    );
  }

  Future<void> toggleDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("darkMode", value);

    setState(() {
      darkMode = value;
    });
  }

  Future<void> toggleNotifications(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notifications", value);
    setState(() {
      notifications = value;
    });
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      isLoggedIn = false;
      username = "";
      darkMode = false;
      notifications = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
       return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Hello $username",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text("Dark Mode"),
              value: darkMode,
              onChanged: toggleDarkMode,
            ),

            SwitchListTile(
              title: const Text("Notifications"),
              value: notifications,
              onChanged: toggleNotifications,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: logout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
