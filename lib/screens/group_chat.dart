import 'package:flutter/material.dart';

class GroupChat extends StatefulWidget {
  final Map<String, dynamic> groupData;

  const GroupChat({super.key, required this.groupData});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];
  List<Map<String, dynamic>> members = [];

  @override
  void initState() {
    super.initState();
    _loadGroupData();
  }

  void _loadGroupData() {
    // Sample members data
    members = [
      {
        'name': 'Rajesh Kumar',
        'role': 'Admin',
        'isOnline': true,
        'avatar': 'RK',
        'lastSeen': 'Online',
      },
      {
        'name': 'Priya Sharma',
        'role': 'Moderator',
        'isOnline': true,
        'avatar': 'PS',
        'lastSeen': 'Online',
      },
      {
        'name': 'Amit Singh',
        'role': 'Member',
        'isOnline': false,
        'avatar': 'AS',
        'lastSeen': '2h ago',
      },
      {
        'name': 'Neha Gupta',
        'role': 'Member',
        'isOnline': true,
        'avatar': 'NG',
        'lastSeen': 'Online',
      },
    ];

    // Sample messages
    messages = [
      {
        'id': 1,
        'text': 'Welcome everyone to ${widget.groupData['name']}! 🎉',
        'sender': 'Rajesh Kumar',
        'senderAvatar': 'RK',
        'isMe': false,
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'type': 'text',
        'isAdmin': true,
      },
      {
        'id': 2,
        'text':
            'Thanks for creating this group! Looking forward to our discussions.',
        'sender': 'Priya Sharma',
        'senderAvatar': 'PS',
        'isMe': false,
        'timestamp': DateTime.now().subtract(
          const Duration(hours: 1, minutes: 45),
        ),
        'type': 'text',
        'isAdmin': false,
      },
      {
        'id': 3,
        'text': 'Photo shared',
        'sender': 'Amit Singh',
        'senderAvatar': 'AS',
        'isMe': false,
        'timestamp': DateTime.now().subtract(
          const Duration(hours: 1, minutes: 30),
        ),
        'type': 'image',
        'isAdmin': false,
      },
      {
        'id': 4,
        'text': widget.groupData['lastMessage'] ?? 'Great to be here!',
        'sender': 'You',
        'senderAvatar': 'Me',
        'isMe': true,
        'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
        'type': 'text',
        'isAdmin': false,
      },
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'id': messages.length + 1,
          'text': _messageController.text.trim(),
          'sender': 'You',
          'senderAvatar': 'Me',
          'isMe': true,
          'timestamp': DateTime.now(),
          'type': 'text',
          'isAdmin': false,
        });
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildGroupAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildGroupMessageBubble(messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildGroupAppBar() {
    final onlineCount = members.where((m) => m['isOnline']).length;

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
      title: InkWell(
        onTap: () => _showGroupInfo(),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: _getCategoryColor(
                    widget.groupData['category'] ?? 'default',
                  ),
                  child: Text(
                    widget.groupData['avatar'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.groupData['isOfficial'])
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
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.groupData['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '$onlineCount online • ${widget.groupData['memberCount']} members',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _showGroupInfo(),
          icon: Icon(Icons.info_outline, color: Colors.grey[600]),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert_rounded, color: Colors.grey[600]),
          onSelected: (value) {
            switch (value) {
              case 'info':
                _showGroupInfo();
                break;
              case 'media':
                _showGroupMedia();
                break;
              case 'mute':
                _muteGroup();
                break;
              case 'leave':
                _leaveGroup();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20),
                  SizedBox(width: 12),
                  Text('Group Info'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'media',
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined, size: 20),
                  SizedBox(width: 12),
                  Text('Media & Files'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'mute',
              child: Row(
                children: [
                  Icon(Icons.notifications_off_outlined, size: 20),
                  SizedBox(width: 12),
                  Text('Mute Group'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'leave',
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, size: 20, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Leave Group', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey[200]),
      ),
    );
  }

  Widget _buildGroupMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'];
    final timestamp = message['timestamp'] as DateTime;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 4),
              child: Row(
                children: [
                  Text(
                    message['sender'],
                    style: TextStyle(
                      fontSize: 12,
                      color: _getSenderColor(message['sender']),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (message['isAdmin'])
                    Container(
                      margin: const EdgeInsets.only(left: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'ADMIN',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF10B981),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: _getCategoryColor(
                    widget.groupData['category'] ?? 'default',
                  ),
                  child: Text(
                    message['senderAvatar'][0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],

              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isMe ? const Color(0xFF667EEA) : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: Radius.circular(isMe ? 20 : 4),
                            bottomRight: Radius.circular(isMe ? 4 : 20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: _buildGroupMessageContent(message, isMe),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          left: 12,
                          right: 12,
                        ),
                        child: Text(
                          _formatTime(timestamp),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (isMe) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF667EEA),
                  child: const Text(
                    'Me',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupMessageContent(Map<String, dynamic> message, bool isMe) {
    switch (message['type']) {
      case 'image':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Community event photo',
              style: TextStyle(
                fontSize: 14,
                color: isMe ? Colors.white : const Color(0xFF374151),
              ),
            ),
          ],
        );

      case 'announcement':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (isMe ? Colors.white : const Color(0xFF667EEA)).withOpacity(
              0.1,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (isMe ? Colors.white : const Color(0xFF667EEA))
                  .withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.campaign_rounded,
                color: isMe ? Colors.white : const Color(0xFF667EEA),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message['text'],
                  style: TextStyle(
                    fontSize: 15,
                    color: isMe ? Colors.white : const Color(0xFF374151),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );

      default:
        return Text(
          message['text'],
          style: TextStyle(
            fontSize: 15,
            color: isMe ? Colors.white : const Color(0xFF374151),
            height: 1.4,
          ),
        );
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attachment button
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  _showGroupAttachmentOptions();
                },
                icon: Icon(Icons.add_rounded, color: Colors.grey[600]),
              ),
            ),

            const SizedBox(width: 12),

            // Message input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Message ${widget.groupData['name']}...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Send button
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF667EEA),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGroupInfo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Group Info Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: _getCategoryColor(
                        widget.groupData['category'] ?? 'default',
                      ),
                      child: Text(
                        widget.groupData['avatar'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.groupData['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.groupData['description'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoStat(
                          'Members',
                          widget.groupData['memberCount'].toString(),
                        ),
                        _buildInfoStat(
                          'Online',
                          members.where((m) => m['isOnline']).length.toString(),
                        ),
                        _buildInfoStat('Media', '23'),
                      ],
                    ),
                  ],
                ),
              ),

              // Members List
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: members.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Text(
                          'Members',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    }

                    final member = members[index - 1];
                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFF667EEA),
                            child: Text(
                              member['avatar'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (member['isOnline'])
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Row(
                        children: [
                          Text(
                            member['name'],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (member['role'] == 'Admin')
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'ADMIN',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF10B981),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      subtitle: Text(member['lastSeen']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF667EEA),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  void _showGroupAttachmentOptions() {
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
            const Text(
              'Share with Group',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                _buildGroupAttachmentOption(
                  icon: Icons.photo_camera_rounded,
                  label: 'Camera',
                  color: const Color(0xFFEF4444),
                  onTap: () => Navigator.pop(context),
                ),
                _buildGroupAttachmentOption(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  color: const Color(0xFF10B981),
                  onTap: () => Navigator.pop(context),
                ),
                _buildGroupAttachmentOption(
                  icon: Icons.description_rounded,
                  label: 'Document',
                  color: const Color(0xFF667EEA),
                  onTap: () => Navigator.pop(context),
                ),
                _buildGroupAttachmentOption(
                  icon: Icons.campaign_rounded,
                  label: 'Announce',
                  color: const Color(0xFFF59E0B),
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

  Widget _buildGroupAttachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  void _showGroupMedia() {
    // Implementation for showing group media
  }

  void _muteGroup() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.groupData['name']} muted'),
        backgroundColor: const Color(0xFF667EEA),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _leaveGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Group'),
        content: Text(
          'Are you sure you want to leave ${widget.groupData['name']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Leave', style: TextStyle(color: Colors.red)),
          ),
        ],
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

  Color _getSenderColor(String sender) {
    final colors = [
      const Color(0xFF667EEA),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFF8B5CF6),
    ];
    return colors[sender.hashCode % colors.length];
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
