import 'package:community_app/screens/group_chat.dart';
import 'package:flutter/material.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _myGroups = [
    {
      'id': 1,
      'name': 'Delhi Youth Wing Official',
      'description': 'Official group for Delhi Youth Wing members',
      'memberCount': 1247,
      'lastMessage': 'Meeting scheduled for tomorrow at 6 PM',
      'lastMessageTime': '2m ago',
      'unreadCount': 5,
      'isOfficial': true,
      'isActive': true,
      'avatar': 'DY',
      'category': 'official',
    },
    {
      'id': 2,
      'name': 'Community Volunteers',
      'description': 'Volunteer coordination and activities',
      'memberCount': 389,
      'lastMessage': 'Great job on today\'s cleanup drive! 🌿',
      'lastMessageTime': '15m ago',
      'unreadCount': 12,
      'isOfficial': false,
      'isActive': true,
      'avatar': 'CV',
      'category': 'volunteer',
    },
    {
      'id': 3,
      'name': 'Policy Discussion Forum',
      'description': 'Open discussions on policy matters',
      'memberCount': 567,
      'lastMessage': 'New healthcare proposal uploaded',
      'lastMessageTime': '1h ago',
      'unreadCount': 0,
      'isOfficial': true,
      'isActive': true,
      'avatar': 'PD',
      'category': 'policy',
    },
    {
      'id': 4,
      'name': 'Local Leaders Network',
      'description': 'Coordination between local leaders',
      'memberCount': 89,
      'lastMessage': 'Weekly report submitted',
      'lastMessageTime': '3h ago',
      'unreadCount': 3,
      'isOfficial': false,
      'isActive': false,
      'avatar': 'LL',
      'category': 'leadership',
    },
  ];

  final List<Map<String, dynamic>> _discoverGroups = [
    {
      'id': 5,
      'name': 'Women Empowerment Cell',
      'description': 'Promoting women\'s rights and empowerment',
      'memberCount': 234,
      'isOfficial': true,
      'avatar': 'WE',
      'category': 'social',
    },
    {
      'id': 6,
      'name': 'Environmental Action Group',
      'description': 'Climate action and environmental awareness',
      'memberCount': 445,
      'isOfficial': false,
      'avatar': 'EA',
      'category': 'environment',
    },
    {
      'id': 7,
      'name': 'Student Council Delhi',
      'description': 'Student representatives and activities',
      'memberCount': 678,
      'isOfficial': true,
      'avatar': 'SC',
      'category': 'education',
    },
    {
      'id': 8,
      'name': 'Senior Citizens Welfare',
      'description': 'Support and activities for senior citizens',
      'memberCount': 156,
      'isOfficial': false,
      'avatar': 'SW',
      'category': 'welfare',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _isSearching = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search groups...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey[500],
                  ),
                  suffixIcon: _isSearching
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _isSearching = false;
                            });
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: Colors.grey[500],
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF667EEA),
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: const Color(0xFF667EEA),
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'My Groups'),
                Tab(text: 'Discover'),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildMyGroupsTab(), _buildDiscoverTab()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateGroupDialog();
        },
        backgroundColor: const Color(0xFF667EEA),
        icon: const Icon(Icons.group_add_rounded, color: Colors.white),
        label: const Text(
          'New Group',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildMyGroupsTab() {
    final filteredGroups = _isSearching
        ? _myGroups
              .where(
                (group) =>
                    group['name'].toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ||
                    group['description'].toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
              )
              .toList()
        : _myGroups;

    return filteredGroups.isEmpty
        ? _buildEmptyState(
            'No groups found',
            'Try searching with different keywords',
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredGroups.length,
            itemBuilder: (context, index) {
              return _buildGroupCard(filteredGroups[index], isMyGroup: true);
            },
          );
  }

  Widget _buildDiscoverTab() {
    final filteredGroups = _isSearching
        ? _discoverGroups
              .where(
                (group) =>
                    group['name'].toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ||
                    group['description'].toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
              )
              .toList()
        : _discoverGroups;

    return Column(
      children: [
        // Categories
        if (!_isSearching) ...[
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryCard(
                  'All',
                  Icons.apps_rounded,
                  const Color(0xFF667EEA),
                ),
                _buildCategoryCard(
                  'Official',
                  Icons.verified_rounded,
                  const Color(0xFF10B981),
                ),
                _buildCategoryCard(
                  'Social',
                  Icons.people_rounded,
                  const Color(0xFFF59E0B),
                ),
                _buildCategoryCard(
                  'Environment',
                  Icons.eco_rounded,
                  const Color(0xFF059669),
                ),
                _buildCategoryCard(
                  'Education',
                  Icons.school_rounded,
                  const Color(0xFF8B5CF6),
                ),
              ],
            ),
          ),
        ],

        // Groups
        Expanded(
          child: filteredGroups.isEmpty
              ? _buildEmptyState(
                  'No groups found',
                  'Try searching with different keywords',
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredGroups.length,
                  itemBuilder: (context, index) {
                    return _buildGroupCard(
                      filteredGroups[index],
                      isMyGroup: false,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(
    Map<String, dynamic> group, {
    required bool isMyGroup,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupChat(groupData: group),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Group Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: _getCategoryColor(group['category']),
                    child: Text(
                      group['avatar'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (group['isOfficial'])
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Color(0xFF1DA1F2),
                          size: 16,
                        ),
                      ),
                    ),
                  if (isMyGroup && group['isActive'] == false)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 16),

              // Group Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            group['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isMyGroup && group['lastMessageTime'] != null)
                          Text(
                            group['lastMessageTime'],
                            style: TextStyle(
                              fontSize: 12,
                              color: group['unreadCount'] > 0
                                  ? const Color(0xFF667EEA)
                                  : Colors.grey[500],
                              fontWeight: group['unreadCount'] > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      group['description'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          Icons.people_rounded,
                          size: 16,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${group['memberCount']} members',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        if (isMyGroup && group['lastMessage'] != null) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '• ${group['lastMessage']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: group['unreadCount'] > 0
                                    ? const Color(0xFF374151)
                                    : Colors.grey[500],
                                fontWeight: group['unreadCount'] > 0
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Action Button & Unread Count
              Column(
                children: [
                  if (isMyGroup) ...[
                    if (group['unreadCount'] > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFF667EEA),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          group['unreadCount'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () {
                        _joinGroup(group);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF667EEA),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Join',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.groups_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _showCreateGroupDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Create New Group',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildCreateOption(
                  icon: Icons.public_rounded,
                  title: 'Public Group',
                  subtitle: 'Anyone can join',
                  color: const Color(0xFF10B981),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(width: 16),
                _buildCreateOption(
                  icon: Icons.lock_rounded,
                  title: 'Private Group',
                  subtitle: 'Invite only',
                  color: const Color(0xFF667EEA),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _joinGroup(Map<String, dynamic> group) {
    setState(() {
      _myGroups.add({
        ...group,
        'lastMessage': 'Welcome to ${group['name']}!',
        'lastMessageTime': 'Just now',
        'unreadCount': 1,
        'isActive': true,
      });
      _discoverGroups.removeWhere((g) => g['id'] == group['id']);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joined ${group['name']}'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'official':
        return const Color(0xFF10B981);
      case 'volunteer':
        return const Color(0xFF667EEA);
      case 'policy':
        return const Color(0xFF8B5CF6);
      case 'leadership':
        return const Color(0xFFEF4444);
      case 'social':
        return const Color(0xFFF59E0B);
      case 'environment':
        return const Color(0xFF059669);
      case 'education':
        return const Color(0xFF3B82F6);
      case 'welfare':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
