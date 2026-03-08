import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:badges/badges.dart'
    as badges; // Aliased to avoid naming conflicts

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Profile UI',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const ProfileScreen(), // Now calling a StatefulWidget
    );
  }
}

// CONVERTED to StatefulWidget
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- STATE VARIABLES ---
  bool _isFollowing = false; // Toggles the Follow button
  int _followersCount = 834; // Dynamic counter
  bool _showGrid = true; // Toggles between Grid and Tagged tabs
  int _currentBottomNavIndex = 4; // Starts on the Profile tab (index 4)

  // Function to handle the follow button press
  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      // Increment or decrement the follower count based on the new state
      if (_isFollowing) {
        _followersCount++;
      } else {
        _followersCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 16),
            const SizedBox(width: 4),
            const Text('dmytro_il'),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () {},
              iconSize: 20,
            ),
          ],
        ),
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header (Avatar and Stats)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile Picture
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Stats
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('54', 'Posts'),
                        // Using our dynamic _followersCount state variable here
                        _buildStatColumn(
                          _followersCount.toString(),
                          'Followers',
                        ),
                        _buildStatColumn('162', 'Following'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bio Section (Using ReadMore Package)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dmytro Ilnytskiy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Software Engineering student at AUK. '),
                        TextSpan(
                          text: '@thebestone',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  // PACKAGE 1: ReadMoreText for expandable bio
                  const ReadMoreText(
                    'Everything is designed. Passionate about Python, Dart, and building modern web and mobile applications. Exploring the world of linear algebra and stats. 🚀',
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' more',
                    trimExpandedText: ' less',
                    style: TextStyle(color: Colors.black87),
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Dynamic Follow / Edit Profile Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // Call our setState function when pressed
                  onPressed: _toggleFollow,
                  style: ElevatedButton.styleFrom(
                    // Change colors dynamically based on _isFollowing state
                    backgroundColor: _isFollowing
                        ? Colors.grey.shade200
                        : Colors.blue,
                    foregroundColor: _isFollowing ? Colors.black : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    // Change text dynamically based on state
                    _isFollowing ? 'Following' : 'Follow',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Story Highlights (Unchanged)
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildHighlightItem('New', isAdd: true),
                  _buildHighlightItem('Flame', imageName: 'pic14.jpg'),
                  _buildHighlightItem('Rose', imageName: 'pic13.jpg'),
                  _buildHighlightItem('Nature', imageName: 'pic8.jpg'),
                ],
              ),
            ),

            const Divider(height: 1),

            // Interactive Tab Bar (Grid vs Tagged)
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _showGrid = true; // Switch to Grid
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            // Highlight border if active
                            color: _showGrid
                                ? Colors.black
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        Icons.grid_on,
                        // Change color if active
                        color: _showGrid ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _showGrid = false; // Switch to Tagged
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: !_showGrid
                                ? Colors.black
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        Icons.person_pin_outlined,
                        color: !_showGrid ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Conditional Rendering based on Tab State
            _showGrid ? _buildPhotoGrid() : _buildTaggedEmptyState(),

            // Add some padding at the bottom so we can scroll past the last items easily
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Interactive Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false, // Changed to false to match Instagram
        showUnselectedLabels: false,
        currentIndex: _currentBottomNavIndex, // Driven by state
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index; // Update active icon
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            activeIcon: Icon(Icons.home, size: 30), // Solid icon when active
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            activeIcon: Icon(Icons.search, size: 30, weight: 800),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined, size: 30),
            activeIcon: Icon(Icons.add_box, size: 30),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            // PACKAGE 2: Badges to show a notification dot/counter
            icon: badges.Badge(
              badgeContent: const Text(
                '3',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              position: badges.BadgePosition.topEnd(top: -5, end: -5),
              child: const Icon(Icons.favorite_border, size: 30),
            ),
            activeIcon: const Icon(Icons.favorite, size: 30),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  // Show a black ring around the profile icon if it is the active tab
                  color: _currentBottomNavIndex == 4
                      ? Colors.black
                      : Colors.transparent,
                  width: 2,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // --- EXTRACTED WIDGETS FOR CLEANLINESS ---

  // Refactored Grid view
  Widget _buildPhotoGrid() {
    List<String> images = [
      'assets/images/pic2.jpg',
      'assets/images/pic3.jpg',
      'assets/images/pic4.jpg',
      'assets/images/pic5.jpg',
      'assets/images/pic6.jpg',
      'assets/images/pic7.jpg',
      'assets/images/pic8.jpg',
      'assets/images/pic9.jpg',
      'assets/images/pic10.jpg',
      'assets/images/pic11.jpg',
      'assets/images/pic12.jpg',
      'assets/images/pic13.jpg',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  // Empty state for the "Tagged" tab
  Widget _buildTaggedEmptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.person_pin_outlined, size: 60, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'Photos and Videos of You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'When people tag you in photos, they\'ll appear here.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for Stats
  Widget _buildStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  // Helper widget for Story Highlights
  Widget _buildHighlightItem(
    String title, {
    bool isAdd = false,
    String? imageName,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAdd ? Colors.white : null,
                  image: !isAdd && imageName != null
                      ? DecorationImage(
                          image: AssetImage('assets/images/' + imageName),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: isAdd ? const Icon(Icons.add, size: 30) : null,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
