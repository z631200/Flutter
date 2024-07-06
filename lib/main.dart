import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(color: Colors.white), // Set your desired text color here
          ),
        ),

      ),
      home: Scaffold(
        body: Navigation()
      ),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;


  final List<Widget> pages = [
    CourseManagementPage(),
    PromptManagementPage(),
    PersonalInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.class_rounded),
            icon: Icon(Icons.class_outlined),
            label: '課程管理',
            
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.design_services_rounded),
            icon: Icon(Icons.design_services_outlined),
            label: 'Prompt 管理',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle_rounded),
            icon: Icon(Icons.account_circle_outlined),
            label: '個人資訊',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
    );
  }
}

class PromptManagementPage extends StatelessWidget {
  const PromptManagementPage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text('Prompt 管理 Page'));
}

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.asset('images/algo.png'),
        ),
      ),
    );
  }
}


class CourseManagementPage extends StatefulWidget {
  const CourseManagementPage({super.key});

  @override
  _CourseManagementPageState createState() => _CourseManagementPageState();
}

class _CourseManagementPageState extends State<CourseManagementPage> {
  
  List<Widget> courseTiles = [];
  final TextEditingController _courseNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Add the AddCourseTile initially
    courseTiles.add(AddCourseTile(onAddCourse: _promptCourseName));
  }

  void _promptCourseName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('請輸入課程名稱'),
          content: TextField(
            controller: _courseNameController,
            decoration: InputDecoration(hintText: 'Course Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addCourseTile(_courseNameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _addCourseTile(String courseName) {
    setState(() {
      courseTiles.insert(courseTiles.length - 1, CourseTile(title: courseName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 61, 61, 61),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns
                  crossAxisSpacing: 75, // Horizontal spacing between items
                  mainAxisSpacing: 75, // Vertical spacing between items
                ),
                itemCount: courseTiles.length,
                itemBuilder: (context, index) {
                  return courseTiles[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}

class CourseTile extends StatelessWidget {
  final String title;
  final String? imageUrl;

  CourseTile({required this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color.fromARGB(255, 48, 48, 48),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageUrl != null)
                Image.asset(imageUrl!)
              else
                Icon(
                  Icons.book_outlined,
                  size: 100,
                  color: Colors.white, // Change 'Colors.red' to your desired color
                ),

              SizedBox(height: 4),

              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white), // Change 'Colors.red' to your desired color
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white, // Change 'Colors.red' to your desired color
                    ),
                    onSelected: (String newValue) {
                      // Handle the selection of an item
                      // You can add your logic here
                      print('Selected: $newValue');
                    },
                    itemBuilder: (BuildContext context) {
                      return <String>['編輯名稱', '刪除課程'].map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCourseTile extends StatelessWidget {

final VoidCallback onAddCourse;

const AddCourseTile({required this.onAddCourse});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAddCourse,
      child: Card(
        color: Color.fromARGB(255, 48, 48, 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 100,
              color: Colors.white, // Change 'Colors.red' to your desired color
            ),
            SizedBox(height: 8),
            Text(
                    "新增課程",
                    style: TextStyle(color: Colors.white), // Change 'Colors.red' to your desired color
                  ),
          ],
        ),
      ),
    );
  }
}