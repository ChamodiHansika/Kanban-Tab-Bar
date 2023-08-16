import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(TabbedApp());
}

class Task {
  final String progressStage;
  final String taskTitles;
  final Color flagColor;
  final String linkedTask;
  final String assignTo;
  final String reportTo;
  final String startDate;
  final String endDate;
  final String description;

  Task({
    required this.progressStage,
    required this.taskTitles,
    required this.flagColor,
    required this.linkedTask,
    required this.assignTo,
    required this.reportTo,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
}

class TabbedApp extends StatefulWidget {
  @override
  _TabbedAppState createState() => _TabbedAppState();
}

class _TabbedAppState extends State<TabbedApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> progressStages = [
    "ToDo",
    "In Progress",
    "QA",
    "Done",
    "Started",
  ];

  List<String> taskTitles = [
    "FRONTEND",
    "BACKEND",
    "Card 3",
    "Card 4",
    "Card 5",
    "Card 6",
    "Card 7",
    "Card 8",
    "Card 9",
    "Card 10",
  ];

  List<Tab> getTabs() {
    return progressStages.map((name) => Tab(text: name)).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: progressStages.length,
      vsync: this,
    );

    fetchData(); // Call the method to fetch data from the API
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.9:4000/api/project'));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<Task> fetchedTasks = [];
        for (var taskData in responseData) {
          final progressStage = taskData['progressStage'];
          final title = taskData['title'];
          final flagColor = _getColorFromHex(taskData['flagColor']);
          final linkedTask = taskData['linkedTask'];
          final assignTo = taskData['assignTo'];
          final reportTo = taskData['reportTo'];
          final startDate = taskData['startDate'];
          final endDate = taskData['endDate'];
          final description = taskData['description'];

          Task task = Task(
            progressStage: progressStage,
            taskTitles: title,
            flagColor: flagColor,
            linkedTask: linkedTask,
            assignTo: assignTo,
            reportTo: reportTo,
            startDate: startDate,
            endDate: endDate,
            description: description,
          );
          fetchedTasks.add(task);
        }
        setState(() {
          taskTitles = fetchedTasks.map((task) => task.taskTitles).toList();
        });
      } else if (response.statusCode == 400) {
        print('Bad');
      } else if (response.statusCode == 401) {
        print('Request is not authorized');
      } else {
        print('Request failed with status: ${response.statusCode}.');
        final errorMessage = responseData['error'];
        print(errorMessage);
      }
    } catch (e) {
      // Handle the exception here
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabbed App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 237, 250),
        appBar: AppBar(
          title: Text('Tabbed App'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: getTabs(),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(
            progressStages.length, //PROGRESS STAGES
                (index) => ListView.builder(
              itemCount: taskTitles.length, //TASKS
              itemBuilder: (context, cardIndex) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.indigo, //<-- SEE HERE
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.indigoAccent[100],
                          title: Text("FONT END DESIGN"),
                          content: DefaultTextStyle(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            child: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Row(
                                    children: [
                                      Text("Flag:"),
                                      Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text("Linked Task:"),
                                  SizedBox(height: 8.0),
                                  Text("Assign To:"),
                                  SizedBox(height: 8.0),
                                  Text("Report To:"),
                                  SizedBox(height: 8.0),
                                  Text("Start Date: "),
                                  SizedBox(height: 8.0),
                                  Text("End Date: "),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "Description: Inside the app bar create 5 tab bar elements using React JS framework.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.indigoAccent, //<-- SEE HERE
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 2, // Adjust the elevation as desired
                    margin: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ), // Adjust the margin as desired
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.all(16), // Adjust the content padding as desired
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/profile_image.png'), // Replace with your image
                      ),
                      title: Text(
                        taskTitles[cardIndex],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
