import 'package:employer/models/employee_model.dart';
import 'package:employer/widgets/employee_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _yearController = TextEditingController();

  late final bool isMoreThanFive;

  List userProfilesList = [];

  String userID = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDatabaseList();
  }

  fetchUserInfo() async {
    var getUser = FirebaseAuth.instance.currentUser;
    if (getUser != null) {
      userID = getUser.uid;
    }
  }

// Fetch the Data for each employee and store it in LIST.
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      if (kDebugMode) {
        print('Unable to retrieve');
      }
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

// Create new entry in database via Dialog box
  Future updateData(
      String name, String job, String year, String userID, bool isFive) async {
    await DatabaseManager().createUserData(name, job, year, userID, isFive);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            //People
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'People',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        userProfilesList.length.toString(),
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(Icons.logout))
                ],
              ),
            ),

            //List of Employee Tile
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: userProfilesList.length,
                itemBuilder: (context, index) {
                  return EmplyeeTile(
                    ejob: userProfilesList[index]['job'],
                    ename: userProfilesList[index]['name'],
                    eYear: userProfilesList[index]['year'],
                    isGreen: userProfilesList[index]['isFive'],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialogBox(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

//
// ======================= END OF Scaffold ====================================
//

// Dialog for add new entry
  openDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Employee Details'),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: _jobController,
                    decoration: const InputDecoration(hintText: 'Job'),
                  ),
                  TextField(
                    controller: _yearController,
                    decoration:
                        const InputDecoration(hintText: 'Year of Joining'),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  submitAction(context);
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

// Sumbit Buttoin fuction to add new entry
  submitAction(BuildContext context) {
    bool five = moreThanFive(_yearController.text);
    updateData(_nameController.text, _jobController.text, _yearController.text,
        userID, five);
    _nameController.clear();
    _jobController.clear();
    _yearController.clear();
  }

// Checking if Employee is more than 5 year old in Company
  bool moreThanFive(String year) {
    String dt = DateFormat("yyyy").format(DateTime.now());
    int calcluate = int.parse(dt) - int.parse(year);

    if (calcluate > 5) {
      return true;
    }
    return false;
  }
}
