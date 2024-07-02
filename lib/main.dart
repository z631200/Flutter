import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavigationExample(),
      
      );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
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

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color.fromARGB(255, 88, 228, 236),
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


// class CourseManagementPage extends StatelessWidget {
//   const CourseManagementPage({super.key});

//   @override
//   Widget build(BuildContext context) => Center(child: Text('課程管理 Page'));
// }

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
        appBar: AppBar(
          title: const Text('Image Example'),
        ),
        body: Center(
          child: Image.asset('images/algo.png'),
        ),
      ),
    );
  }
}


class CourseManagementPage extends StatelessWidget {
  const CourseManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 75,
          mainAxisSpacing: 75,
          children: [
            CourseTile(
              title: '演算法',
              // imageUrl: 'images/algo.png', // Replace with actual image URL
              isDropdown: true,
            ),
            CourseTile(title: '演算法'),
            CourseTile(title: '資料結構'),
            CourseTile(title: '演算法'),
            CourseTile(title: '資料結構'),
            CourseTile(title: '演算法'),
            AddCourseTile(),
            
          ],
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool isDropdown;

  CourseTile({required this.title, this.imageUrl, this.isDropdown = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl != null)
            Image.network(
              imageUrl!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
          else
            Icon(Icons.book, size: 50),
          SizedBox(height: 8),
          Text(title),
          if (isDropdown) Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

class AddCourseTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle add course action
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 50),
            SizedBox(height: 8),
            Text('新增課程'),
          ],
        ),
      ),
    );
  }
}