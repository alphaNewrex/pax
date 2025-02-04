import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pax/objects/tasks.dart';
import 'package:pax/screens/posts/posts.dart';
import 'package:pax/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

OurTheme _theme = OurTheme();
late CollectionReference users;
late FirebaseAuth _auth = FirebaseAuth.instance;
late User? _user;
Tasks _tasks = Tasks();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    _auth = FirebaseAuth.instance;
    _user = FirebaseAuth.instance.currentUser;
    users = FirebaseFirestore.instance.collection('users');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text("Logo!", style: TextStyle(color: Colors.black)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: InkWell(
                onTap: () async {
                  await _auth.signOut();
                  Navigator.popAndPushNamed(context, '/login_page');
                },
                child: Container(
                  width: _width * 0.22,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color(0xFFFF585C),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                setTask();
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const Text(
                        "Welcome back,",
                        style: TextStyle(color: Colors.black, fontSize: 22.0),
                      ),
                      Text(
                        _user!.email!.split("@")[0],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/task_page',
                              arguments: {
                                'taskNumber': snapshot.data!['taskNumber']
                              });
                        },
                        child: Center(
                          child: Container(
                            width: _width * 0.9,
                            height: _height * 0.17,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xFFFE8180)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset("assets/images/activity.png"),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Activity of the Day",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21.0),
                                    ),
                                    SizedBox(
                                      width: _width * 0.4,
                                      child: Center(
                                        child: Text(
                                          _tasks.tasksList[
                                              snapshot.data!['taskNumber']],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Center(
                          child: Container(
                            width: _width * 0.9,
                            height: _height * 0.17,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xFF64A4DA)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: _width * 0.13,
                                ),
                                Image.asset("assets/images/running.png"),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Text(
                                  "999",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0),
                                ),
                                SizedBox(
                                  width: _width * 0.3,
                                ),
                                Image.asset("assets/images/sleeping.png"),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Text(
                                  "7 hr",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0),
                                ),
                                SizedBox(
                                  width: _width * 0.07,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/fitness');
                            },
                            child: Center(
                              child: Container(
                                width: _width * 0.33,
                                height: _height * 0.17,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: const Color(0xFFE76A40)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/fitness.png"),
                                    const Text(
                                      "Fitness",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/routines');
                            },
                            child: Center(
                              child: Container(
                                width: _width * 0.56,
                                height: _height * 0.17,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: const Color(0xFF8F98FD)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/checklist.png",
                                      fit: BoxFit.cover,
                                    ),
                                    const Text(
                                      "Checklist",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: _theme.secondaryColor,
                ),
              );
            }),
      ),
    );
  }

  Future<void> setTask() async {
    Random _random = Random();
    await users.doc(_user!.uid).get().then((value) async {
      if (value['taskNumber'].toString().isEmpty ||
          value['taskDate'] !=
              DateFormat('EEEEE', 'en_US').format(DateTime.now())) {
        await users.doc(_user!.uid).update({
          'taskNumber': _random.nextInt(6),
          'taskDate': DateFormat('EEEEE', 'en_US').format(DateTime.now())
        });
      }
    });
  }

  Future<void> getTask() async {
    int _taskNumber = 0;
    await users.doc(_user!.uid).get().then((value) async {
      if (value['taskNumber'].toString().isNotEmpty) {
        _taskNumber = value['taskNumber'];
      }
    });
  }
}
