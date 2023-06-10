import 'package:flutter/material.dart';

void main() {
  runApp(TabbedApp());
}

class TabbedApp extends StatefulWidget {
  @override
  _TabbedAppState createState() => _TabbedAppState();
}

class _TabbedAppState extends State<TabbedApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> progressStages = [
    "ToDo",
    "In Progress",
    "QA",
    "Done",
    "Started",
  ];

  List<String> taskTitles = [
    "FRONTEND", "BACKEND", "Card 3", "Card 4", "Card 5", "Card 6", "Card 7", "Card 8", "Card 9", "Card 10",
  ];

  get cardTitles => null;

  List<Tab> getTabs() {
    return progressStages.map((name) => Tab(text: name)).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: progressStages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateTabCount(int count) {
    setState(() {
      progressStages = List<String>.generate(count, (index) => "Tab ${index + 1}");
      _tabController = TabController(length: progressStages.length, vsync: this);
    });
  }

  void displayCardTitle(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
            progressStages.length,//PROGRESS STAGES
                (index) => ListView.builder(
              itemCount: taskTitles.length,//TASKS
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
                              borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor:  Colors.indigoAccent[100],
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
                                  Text("Description: Inside the app bar create 5 tab bar elements using React JS framework."),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close', style: TextStyle(color: Colors.black),),
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
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the margin as desired
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16), // Adjust the content padding as desired
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_image.png'), // Replace with your image
                    ),
                    title: Text(
                      taskTitles[cardIndex],
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
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
