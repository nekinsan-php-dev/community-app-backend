import 'package:flutter/material.dart';
import 'package:community_app/screens/chat_box_screen.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _contacts = [
    {
      'id': 1,
      'name': 'Anita Devi',
      'role': 'Local Leader',
      'location': 'Delhi East',
      'isOnline': true,
      'isOfficial': false,
      'avatar': 'AD',
      'lastSeen': 'Online',
      'mutual': 15,
    },
    {
      'id': 2,
      'name': 'Vikram Singh',
      'role': 'Party Worker',
      'location': 'Delhi South',
      'isOnline': false,
      'isOfficial': false,
      'avatar': 'VS',
      'lastSeen': '2h ago',
      'mutual': 8,
    },
    {
      'id': 3,
      'name': 'Mumbai Youth Wing',
      'role': 'Official Group',
      'location': 'Mumbai',
      'isOnline': true,
      'isOfficial': true,
      'avatar': 'MY',
      'lastSeen': 'Active',
      'mutual': 234,
    },
    {
      'id': 4,
      'name': 'Dr. Sunita Sharma',
      'role': 'Health Committee',
      'location': 'All India',
      'isOnline': false,
      'isOfficial': true,
      'avatar': 'SS',
      'lastSeen': '1d ago',
      'mutual': 45,
    },
    {
      'id': 5,
      'name': 'Rohit Kumar',
      'role': 'Volunteer',
      'location': 'Delhi North',
      'isOnline': true,
      'isOfficial': false,
      'avatar': 'RK',
      'lastSeen': 'Online',
      'mutual': 3,
    },
    {
      'id': 6,
      'name': 'Women Empowerment Cell',
      'role': 'Official Group',
      'location': 'Delhi',
      'isOnline': false,
      'isOfficial': true,
      'avatar': 'WE',
      'lastSeen': '3h ago',
      'mutual': 89,
    },
  ];

  final List<Map<String, dynamic>> _suggestions = [
    {
      'id': 7,
      'name': 'Environmental Action Team',
      'role': 'Initiative Group',
      'location': 'Delhi',
      'isOfficial': false,
      'avatar': 'EA',
      'reason': 'Based on your interests',
      'members': 156,
    },
    {
      'id': 8,
      'name': 'Kiran Patel',
      'role': 'Youth Leader',
      'location': 'Gujarat',
      'isOfficial': false,
      'avatar': 'KP',
      'reason': 'Works in similar initiatives',
      'mutual': 12,
    },
    {
      'id': 9,
      'name': 'Student Council Network',
      'role': 'Education Group',
      'location': 'All India',
      'isOfficial': true,
      'avatar': 'SC',
      'reason': 'Trending in your area',
      'members': 2340,
    },
  ];

  List<Map<String, dynamic>> get filteredContacts {
    if (_searchController.text.isEmpty) {
      return _contacts;
    }
    return _contacts.where((contact) {
      return contact['name'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          contact['role'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          contact['location'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
    }).toList();
  }

  List<Map<String, dynamic>> get filteredSuggestions {
    if (_searchController.text.isEmpty) {
      return _suggestions;
    }
    return _suggestions.where((suggestion) {
      return suggestion['name'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          suggestion['role'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildContactsTab(), _buildSuggestionsTab()],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Color(0xFF374151),
        ),
      ),
      title: const Text(
        'New Conversation',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
      ),
      actions: [
        IconButton(
          onPressed: _showContactOptions,
          icon: Icon(Icons.more_vert_rounded, color: Colors.grey[600]),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey[200]),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
            hintText: 'Search people and groups...',
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
            prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[500]),
            suffixIcon: _isSearching
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _isSearching = false;
                      });
                    },
                    icon: Icon(Icons.clear_rounded, color: Colors.grey[500]),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF667EEA),
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: const Color(0xFF667EEA),
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Contacts'),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    filteredContacts.length.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Tab(text: 'Suggestions'),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return Column(
      children: [
        // Quick Actions
        if (!_isSearching) ...[
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                _buildQuickAction(
                  icon: Icons.group_add_rounded,
                  label: 'Create Group',
                  color: const Color(0xFF10B981),
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Icons.qr_code_scanner_rounded,
                  label: 'Scan QR',
                  color: const Color(0xFF667EEA),
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Icons.person_add_rounded,
                  label: 'Invite',
                  color: const Color(0xFFF59E0B),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(height: 8, color: Colors.grey[100]),
        ],

        // Contacts List
        Expanded(
          child: filteredContacts.isEmpty
              ? _buildEmptyState(
                  'No contacts found',
                  'Try searching with different keywords',
                )
              : ListView.builder(
                  itemCount: filteredContacts.length,
                  itemBuilder: (context, index) {
                    return _buildContactTile(filteredContacts[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSuggestionsTab() {
    return filteredSuggestions.isEmpty
        ? _buildEmptyState(
            'No suggestions',
            'Check back later for new connections',
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredSuggestions.length,
            itemBuilder: (context, index) {
              return _buildSuggestionCard(filteredSuggestions[index]);
            },
          );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: contact['isOfficial']
                  ? const Color(0xFF10B981)
                  : const Color(0xFF667EEA),
              child: Text(
                contact['avatar'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            if (contact['isOnline'])
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            if (contact['isOfficial'])
              Positioned(
                top: 0,
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
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                contact['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (contact['mutual'] != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${contact['mutual']} mutual',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF667EEA),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getRoleColor(contact['role']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      contact['role'],
                      style: TextStyle(
                        fontSize: 11,
                        color: _getRoleColor(contact['role']),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.location_on_rounded,
                    size: 12,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 2),
                  Text(
                    contact['location'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                contact['lastSeen'],
                style: TextStyle(
                  fontSize: 12,
                  color: contact['isOnline']
                      ? const Color(0xFF10B981)
                      : Colors.grey[500],
                  fontWeight: contact['isOnline']
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () => _startChat(contact),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_rounded,
              color: Color(0xFF667EEA),
              size: 18,
            ),
          ),
        ),
        onTap: () => _startChat(contact),
      ),
    );
  }

  Widget _buildSuggestionCard(Map<String, dynamic> suggestion) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: suggestion['isOfficial']
                    ? const Color(0xFF10B981)
                    : const Color(0xFF667EEA),
                child: Text(
                  suggestion['avatar'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      suggestion['role'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _connectSuggestion(suggestion),
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
                  'Connect',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    suggestion['reason'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
                if (suggestion['members'] != null)
                  Text(
                    '${suggestion['members']} members',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (suggestion['mutual'] != null)
                  Text(
                    '${suggestion['mutual']} mutual',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
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
              Icons.people_outline_rounded,
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

  void _startChat(Map<String, dynamic> contact) {
    // Convert contact to chat format
    final chatData = {
      'id': contact['id'],
      'name': contact['name'],
      'lastMessage': 'Say hello! 👋',
      'time': 'Just now',
      'unreadCount': 0,
      'isOnline': contact['isOnline'],
      'isOfficial': contact['isOfficial'],
      'avatar': contact['avatar'],
      'messageType': 'text',
    };

    Navigator.pop(context); // Close new chat screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatBoxScreen(chatData: chatData),
      ),
    );
  }

  void _connectSuggestion(Map<String, dynamic> suggestion) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connected with ${suggestion['name']}'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Move to contacts and start chat
    setState(() {
      _contacts.add({
        'id': suggestion['id'],
        'name': suggestion['name'],
        'role': suggestion['role'],
        'location': suggestion['location'] ?? 'Unknown',
        'isOnline': false,
        'isOfficial': suggestion['isOfficial'],
        'avatar': suggestion['avatar'],
        'lastSeen': 'Just connected',
        'mutual': suggestion['mutual'] ?? suggestion['members'],
      });
      _suggestions.removeWhere((s) => s['id'] == suggestion['id']);
    });

    _tabController.animateTo(0); // Switch to contacts tab
  }

  void _showContactOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
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
            ListTile(
              leading: const Icon(
                Icons.refresh_rounded,
                color: Color(0xFF667EEA),
              ),
              title: const Text('Refresh Contacts'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.import_contacts_rounded,
                color: Color(0xFF10B981),
              ),
              title: const Text('Import Contacts'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.link_rounded, color: Color(0xFFF59E0B)),
              title: const Text('Invite via Link'),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'official group':
      case 'health committee':
        return const Color(0xFF10B981);
      case 'local leader':
      case 'youth leader':
        return const Color(0xFFEF4444);
      case 'party worker':
        return const Color(0xFF667EEA);
      case 'volunteer':
        return const Color(0xFFF59E0B);
      case 'initiative group':
      case 'education group':
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
