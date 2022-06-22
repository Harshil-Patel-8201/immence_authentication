import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:immence_authentication/screens/login.dart';
import 'package:immence_authentication/services/authentication.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<String> getUsername() async {
    final ref = FirebaseDatabase.instance.ref();
    final user = FirebaseAuth.instance.currentUser;
    return ref
        .child('userData')
        .child(user!.uid)
        .once()
        .then((DatabaseEvent databaseEvent) {
      Map values = databaseEvent.snapshot.value as Map;
      print(values['email']);
      String name = values['email'];
      return name;
    });
  }

  Future<String> getPhoneNumber() async {
    final ref = FirebaseDatabase.instance.ref();
    final user = FirebaseAuth.instance.currentUser;
    return ref
        .child('userData')
        .child(user!.uid)
        .once()
        .then((DatabaseEvent databaseEvent) {
      Map values = databaseEvent.snapshot.value as Map;
      print(values['phoneNumber']);
      String name = values['phoneNumber'];
      return name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),

            // Profile...
            Column(
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/image.png',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Color(0xff0231C8),
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Email....
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FutureBuilder<String>(
                    future: getUsername(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Color(0xff0231C8),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        );
                      } else {
                        return const Text(
                          "Loading data...",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xffC6C6C6), thickness: 1),

            // Phone number...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Phone no.',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FutureBuilder<String>(
                    future: getPhoneNumber(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Color(0xff0231C8),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        );
                      } else {
                        return const Text(
                          "Loading data...",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xffC6C6C6), thickness: 1),

            // Log out...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Log out',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await Authentication().signOut().then(
                            (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            ),
                          );
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 25,
                      color: Color(0xff0231C8),
                    ),
                  )
                ],
              ),
            ),
            const Divider(color: Color(0xffC6C6C6), thickness: 1),
          ],
        ),
      ),
    );
  }
}
