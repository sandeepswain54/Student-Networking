import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    StudentDirectoryPage(),
    TweetSectionPage(),
    PlaceholderPage(title: 'Network'),
    PlaceholderPage(title: 'Messages'),
    PlaceholderPage(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Disable swipe
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Tweets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Network',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to home screen (index 0)
            _navigateToHome(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    final _MainNavigationPageState? state = context.findAncestorStateOfType<_MainNavigationPageState>();
    state?.setState(() {
      state._currentIndex = 0;
      state._pageController.jumpToPage(0);
    });
  }
}

class TweetSectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tweets'),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to home screen (index 0)
            _navigateToHome(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TweetCard(
            name: 'Alice Sharma',
            handle: '@alice_sharma',
            content: 'Just built my first Flutter app! So excited to share it with everyone. #FlutterDev #MobileApp',
            time: '2h ago',
            likes: '24',
            retweets: '5',
            comments: '3',
          ),
          TweetCard(
            name: 'Bob Patel',
            handle: '@bob_mech',
            content: 'Working on a new robotics project. Can\'t wait to show the final result at the tech fest next month!',
            time: '5h ago',
            likes: '42',
            retweets: '12',
            comments: '7',
          ),
          TweetCard(
            name: 'Chloe Das',
            handle: '@chloe_iot',
            content: 'Attended an amazing workshop on IoT security today. Learned so much about protecting connected devices from cyber threats.',
            time: '1d ago',
            likes: '87',
            retweets: '23',
            comments: '15',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    final _MainNavigationPageState? state = context.findAncestorStateOfType<_MainNavigationPageState>();
    state?.setState(() {
      state._currentIndex = 0;
      state._pageController.jumpToPage(0);
    });
  }
}

class TweetCard extends StatelessWidget {
  final String name;
  final String handle;
  final String content;
  final String time;
  final String likes;
  final String retweets;
  final String comments;

  TweetCard({
    required this.name,
    required this.handle,
    required this.content,
    required this.time,
    required this.likes,
    required this.retweets,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Text(name[0]),
                  radius: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.verified, color: Colors.blue, size: 16),
                        ],
                      ),
                      Text(
                        '$handle · $time',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(content),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInteractionButton(Icons.chat_bubble_outline, comments),
                _buildInteractionButton(Icons.repeat, retweets),
                _buildInteractionButton(Icons.favorite_border, likes),
                _buildInteractionButton(Icons.share, ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        if (count.isNotEmpty) SizedBox(width: 4),
        if (count.isNotEmpty) Text(count),
      ],
    );
  }
}

class StudentDirectoryPage extends StatefulWidget {
  @override
  _StudentDirectoryPageState createState() => _StudentDirectoryPageState();
}

class _StudentDirectoryPageState extends State<StudentDirectoryPage> {
  List<Map<String, dynamic>> students = [
    {
      'name': 'Alice Sharma',
      'handle': '@alice_sharma',
      'department': 'Computer Science',
      'interests': 'AI, Flutter',
      'image': 'assets/r.jpg',
      'followers': '1.2k',
      'following': 543,
      'posts': 87,
      'isFollowing': false,
    },
    {
      'name': 'Bob Patel',
      'handle': '@bob_mech',
      'department': 'Mechanical',
      'interests': 'CAD, Robotics',
      'image': 'assets/r2.jpg',
      'followers': '856',
      'following': 321,
      'posts': 42,
      'isFollowing': true,
    },
    {
      'name': 'Chloe Das',
      'handle': '@chloe_iot',
      'department': 'Electronics',
      'interests': 'IoT, Cyber Security',
      'image': 'assets/r3.jpg',
      'followers': '2.3k',
      'following': 789,
      'posts': 156,
      'isFollowing': false,
    },
  ];

  String selectedDept = 'All';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = selectedDept == 'All'
        ? students
        : students.where((s) => s['department'] == selectedDept).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Connect'),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Already on home screen, so no navigation needed
            // Optionally show exit confirmation
            _showExitConfirmation(context);
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDept,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    underline: Container(),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    items: ['All', 'Computer Science', 'Mechanical', 'Electronics']
                        .map((dept) => DropdownMenuItem(
                              value: dept,
                              child: Text(
                                dept,
                                style: TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDept = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                var student = filtered[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue[100],
                              child: Text(student['name']![0]),
                              radius: 28,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        student['name']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.verified, 
                                          color: Colors.blue, size: 16),
                                    ],
                                  ),
                                  Text(
                                    student['handle']!,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Department: ${student['department']}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Interests: ${student['interests']}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                student['isFollowing']
                                    ? Icons.person
                                    : Icons.person_add,
                                color: student['isFollowing']
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  student['isFollowing'] =
                                      !student['isFollowing']!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(height: 1),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatColumn('Posts', student['posts'].toString()),
                            _buildStatColumn('Following', student['following'].toString()),
                            _buildStatColumn('Followers', student['followers']!),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Text('Message'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue, 
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Text('View Profile'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue, 
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App?'),
        content: Text('Do you want to exit the application?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop(); // This exits the app
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}

// Helper function to navigate to home
void _navigateToHome(BuildContext context) {
  final _MainNavigationPageState? state = context.findAncestorStateOfType<_MainNavigationPageState>();
  state?.setState(() {
    state._currentIndex = 0;
    state._pageController.jumpToPage(0);
  });
}