import 'package:autofarm/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import '../login/login_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GetStorage _storage = GetStorage();
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child("users");

  String email = "N/A";
  String firstName = "N/A";
  String lastName = "N/A";
  String state = "N/A";
  String phoneNumber = "N/A";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userId = _storage.read('user_id');  // Retrieve user ID from GetStorage

    if (userId != null) {
      DataSnapshot snapshot = await _database.child(userId).get();  // Fetch user data from Firebase
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          email = data["email"] ?? "N/A";
          firstName = data["firstName"] ?? "N/A";
          lastName = data["lastName"] ?? "N/A";
          state = data["state"] ?? "N/A";
          phoneNumber = data["phoneNumber"] ?? "N/A";
        });
      }
    }
  }

  void _logout(BuildContext context) async {
    await _storage.remove('is_logged_in');  // Clear the stored value
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),  // Navigate to LoginPage
          (Route<dynamic> route) => false,  // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(withBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'), // replace with your image
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 20,
              thickness: 2,
              color: Colors.teal,
              indent: 20,
              endIndent: 20,
            ),
            _buildProfileInfo(),
            SizedBox(height: 15,),
            ElevatedButton.icon(
              onPressed: () {
                _logout(context);
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$firstName $lastName",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildProfileField("Email:", Icons.email, email),
              _buildProfileField("First Name:", Icons.person, firstName),
              _buildProfileField("Last Name:", Icons.person, lastName),
              _buildProfileField("State:", Icons.home, state),
              _buildProfileField("Mobile Number:", Icons.phone, phoneNumber),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, IconData icon, String value) {
    return Column(
      children: [
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.teal,
          indent: 20,
          endIndent: 20,
        ),
        Row(
          children: [
            Icon(icon, color: Colors.teal),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(value),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
