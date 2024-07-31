import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/app_colors.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reEnterPasswordController = TextEditingController();

  final DatabaseReference _database = FirebaseDatabase.instance.ref().child("users");
  final GetStorage _storage = GetStorage();  // Initialize GetStorage

  List<String> _states = ["England", "Scotland", "Wales", "Northern Ireland"];
  String? _selectedState;

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _reEnterPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      Map<String, dynamic> user = {
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "state": _selectedState,
        "phoneNumber": _phoneNumberController.text,
        "email": _emailController.text,
      };
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String userId = userCredential.user!.uid;  // Get the user ID
        await _database.child(userId).set(user);  // Save user data with user ID
        await _storage.write('user_id', userId);  // Store the user ID in GetStorage

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully Registered')),
        );
        _clearForm();
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneNumberController.clear();
    _emailController.clear();
    _passwordController.clear();
    _reEnterPasswordController.clear();
    setState(() {
      _selectedState = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 140),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 60),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/logo.png'), // replace with your image
                  ),
                  Text("Auto Farm", style: GoogleFonts.dancingScript(fontSize: 16),),

                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.maybeOf(context)!.size.height,
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(labelText: 'First Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(labelText: 'Last Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'State'),
                              value: _selectedState,
                              items: _states.map((String state) {
                                return DropdownMenuItem<String>(
                                  value: state,
                                  child: Text(state),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedState = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your state';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(labelText: 'Phone Number'),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _reEnterPasswordController,
                              decoration: InputDecoration(labelText: 'Re-enter Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please re-enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _registerUser,
                              child: Text('Register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
