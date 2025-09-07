import 'package:community_app/screens/chat_box_screen.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _chats = [
    {
      'id': 1,
      'name': 'Delhi Youth Wing',
      'lastMessage': 'Meeting scheduled for tomorrow at 6 PM',
      'time': '2m ago',
      'unreadCount': 3,
      'isOnline': true,
      'isOfficial': true,
      'avatar': 'DY',
      'messageType': 'text',
    },
    {
      'id': 2,
      'name': 'Rajesh Kumar',
      'lastMessage': 'Thanks for organizing the rally today! 👏',
      'time': '15m ago',
      'unreadCount': 0,
      'isOnline': false,
      'isOfficial': false,
      'avatar': 'RK',
      'messageType': 'text',
    },
    {
      'id': 3,
      'name': 'Community Volunteers',
      'lastMessage': 'Photo shared',
      'time': '1h ago',
      'unreadCount': 7,
      'isOnline': false,
      'isOfficial': false,
      'avatar': 'CV',
      'messageType': 'image',
    },
    {
      'id': 4,
      'name': 'Priya Sharma',
      'lastMessage': 'Voice message',
      'time': '2h ago',
      'unreadCount': 1,
      'isOnline': true,
      'isOfficial': false,
      'avatar': 'PS',
      'messageType': 'voice',
    },
    {
      'id': 5,
      'name': 'Policy Discussion Group',
      'lastMessage': 'New healthcare proposal document uploaded',
      'time': '3h ago',
      'unreadCount': 12,
      'isOnline': false,
      'isOfficial': true,
      'avatar': 'PD',
      'messageType': 'document',
    },
    {
      'id': 6,
      'name': 'Amit Singh',
      'lastMessage': 'Great work on the voter registration drive!',
      'time': '5h ago',
      'unreadCount': 0,
      'isOnline': false,
      'isOfficial': false,
      'avatar': 'AS',
      'messageType': 'text',
    },
    {
      'id': 7,
      'name': 'Election Committee',
      'lastMessage': 'Video call ended',
      'time': '1d ago',
      'unreadCount': 0,
      'isOnline': false,
      'isOfficial': true,
      'avatar': 'EC',
      'messageType': 'video',
    },
    {
      'id': 8,
      'name': 'Local Leaders Network',
      'lastMessage': 'Weekly report submitted successfully',
      'time': '2d ago',
      'unreadCount': 2,
      'isOnline': false,
      'isOfficial': false,
      'avatar': 'LL',
      'messageType': 'text',
    },
  ];

  List<Map<String, dynamic>> get filteredChats {
    if (_searchController.text.isEmpty) {
      return _chats;
    }
    return _chats.where((chat) {
      return chat['name'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          chat['lastMessage'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
    }).toList();
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
                  hintText: 'Search conversations...',
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

          // Quick Actions
          if (!_isSearching) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  _buildQuickAction(
                    icon: Icons.broadcast_on_personal_rounded,
                    label: 'Broadcast',
                    color: const Color(0xFF10B981),
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _buildQuickAction(
                    icon: Icons.group_add_rounded,
                    label: 'New Group',
                    color: const Color(0xFF667EEA),
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _buildQuickAction(
                    icon: Icons.campaign_rounded,
                    label: 'Announcement',
                    color: const Color(0xFFF59E0B),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(height: 8, color: Colors.grey[100]),
          ],

          // Chat List
          Expanded(
            child: filteredChats.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      return _buildChatTile(filteredChats[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_chat');
        },
        backgroundColor: const Color(0xFF667EEA),
        child: const Icon(Icons.message_rounded, color: Colors.white),
      ),
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

  Widget _buildChatTile(Map<String, dynamic> chat) {
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
              backgroundColor: chat['isOfficial']
                  ? const Color(0xFF10B981)
                  : const Color(0xFF667EEA),
              child: Text(
                chat['avatar'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            if (chat['isOnline'])
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
            if (chat['isOfficial'])
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
                chat['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              chat['time'],
              style: TextStyle(
                fontSize: 12,
                color: chat['unreadCount'] > 0
                    ? const Color(0xFF667EEA)
                    : Colors.grey[500],
                fontWeight: chat['unreadCount'] > 0
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              _getMessageTypeIcon(chat['messageType']),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  chat['lastMessage'],
                  style: TextStyle(
                    fontSize: 14,
                    color: chat['unreadCount'] > 0
                        ? const Color(0xFF374151)
                        : Colors.grey[600],
                    fontWeight: chat['unreadCount'] > 0
                        ? FontWeight.w500
                        : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (chat['unreadCount'] > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF667EEA),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    chat['unreadCount'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatBoxScreen(chatData: chat),
            ),
          );
        },
      ),
    );
  }

  Widget _getMessageTypeIcon(String messageType) {
    IconData icon;
    Color color = Colors.grey[500]!;

    switch (messageType) {
      case 'image':
        icon = Icons.image_rounded;
        color = const Color(0xFF10B981);
        break;
      case 'voice':
        icon = Icons.mic_rounded;
        color = const Color(0xFF667EEA);
        break;
      case 'video':
        icon = Icons.videocam_rounded;
        color = const Color(0xFFEF4444);
        break;
      case 'document':
        icon = Icons.description_rounded;
        color = const Color(0xFFF59E0B);
        break;
      default:
        return const SizedBox.shrink();
    }

    return Icon(icon, size: 16, color: color);
  }

  Widget _buildEmptyState() {
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
              Icons.search_off_rounded,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No conversations found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
