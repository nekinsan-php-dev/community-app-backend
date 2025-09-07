import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'type': 'like',
      'title': 'Priya Sharma liked your post',
      'description': 'Your post about voter registration drive got a new like',
      'time': '2 minutes ago',
      'isRead': false,
      'avatar': 'PS',
      'color': Color(0xFF667EEA),
      'icon': Icons.thumb_up_rounded,
    },
    {
      'id': 2,
      'type': 'comment',
      'title': 'Amit Singh commented on your post',
      'description': '"Great initiative! Count me in for volunteering."',
      'time': '15 minutes ago',
      'isRead': false,
      'avatar': 'AS',
      'color': Color(0xFF10B981),
      'icon': Icons.comment_rounded,
    },
    {
      'id': 3,
      'type': 'follow',
      'title': 'Delhi Youth Wing started following you',
      'description': 'You have a new follower in your network',
      'time': '1 hour ago',
      'isRead': false,
      'avatar': 'DY',
      'color': Color(0xFF8B5CF6),
      'icon': Icons.person_add_rounded,
    },
    {
      'id': 4,
      'type': 'poll',
      'title': 'Vote on Community Poll',
      'description':
          'Community Volunteers wants your opinion on the cleanup drive schedule',
      'time': '2 hours ago',
      'isRead': true,
      'avatar': 'CV',
      'color': Color(0xFFF59E0B),
      'icon': Icons.poll_rounded,
    },
    {
      'id': 5,
      'type': 'group',
      'title': 'Added to Policy Discussion Group',
      'description':
          'Rajesh Kumar added you to the healthcare policy discussion',
      'time': '3 hours ago',
      'isRead': true,
      'avatar': 'RK',
      'color': Color(0xFF06B6D4),
      'icon': Icons.group_add_rounded,
    },
    {
      'id': 6,
      'type': 'announcement',
      'title': 'Important Announcement',
      'description':
          'New community guidelines have been updated. Please review them.',
      'time': '5 hours ago',
      'isRead': true,
      'avatar': 'A',
      'color': Color(0xFFEF4444),
      'icon': Icons.campaign_rounded,
    },
    {
      'id': 7,
      'type': 'mention',
      'title': 'You were mentioned in a post',
      'description':
          'Local Leaders Network mentioned you in their weekly update',
      'time': '1 day ago',
      'isRead': true,
      'avatar': 'LL',
      'color': Color(0xFF667EEA),
      'icon': Icons.alternate_email_rounded,
    },
    {
      'id': 8,
      'type': 'event',
      'title': 'Event Reminder',
      'description':
          'Community rally tomorrow at 6 PM. Don\'t forget to attend!',
      'time': '1 day ago',
      'isRead': true,
      'avatar': 'E',
      'color': Color(0xFF10B981),
      'icon': Icons.event_rounded,
    },
  ];

  List<Map<String, dynamic>> get unreadNotifications =>
      _notifications.where((n) => !n['isRead']).toList();

  List<Map<String, dynamic>> get allNotifications => _notifications;

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
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildAllNotifications(), _buildUnreadNotifications()],
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
        'Notifications',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
      ),
      actions: [
        if (unreadNotifications.isNotEmpty)
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: Color(0xFF667EEA),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        IconButton(
          onPressed: _showNotificationSettings,
          icon: Icon(Icons.settings_outlined, color: Colors.grey[600]),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey[200]),
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
                const Text('All'),
                if (_notifications.isNotEmpty) ...[
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
                      _notifications.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Unread'),
                if (unreadNotifications.isNotEmpty) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      unreadNotifications.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllNotifications() {
    return _buildNotificationsList(allNotifications);
  }

  Widget _buildUnreadNotifications() {
    return _buildNotificationsList(unreadNotifications);
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification['isRead']
            ? Colors.white
            : const Color(0xFF667EEA).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: notification['isRead']
            ? Border.all(color: Colors.grey[200]!)
            : Border.all(color: const Color(0xFF667EEA).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _handleNotificationTap(notification),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar and Icon
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: notification['color'].withOpacity(0.1),
                    child: Text(
                      notification['avatar'],
                      style: TextStyle(
                        color: notification['color'],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: notification['color'],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        notification['icon'],
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: notification['isRead']
                                  ? FontWeight.w600
                                  : FontWeight.bold,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        if (!notification['isRead'])
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF667EEA),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      notification['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          notification['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        const Spacer(),
                        _buildNotificationActions(notification),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationActions(Map<String, dynamic> notification) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!notification['isRead'])
          InkWell(
            onTap: () => _markAsRead(notification['id']),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF667EEA).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Mark read',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF667EEA),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => _deleteNotification(notification['id']),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Icon(Icons.close_rounded, size: 16, color: Colors.grey[400]),
          ),
        ),
      ],
    );
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
              Icons.notifications_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    // Mark as read when tapped
    if (!notification['isRead']) {
      _markAsRead(notification['id']);
    }

    // Handle navigation based on notification type
    switch (notification['type']) {
      case 'like':
      case 'comment':
        // Navigate to post
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening post...'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case 'follow':
        // Navigate to profile
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening profile...'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case 'group':
        // Navigate to group
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening group...'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case 'poll':
        // Navigate to poll
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening poll...'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      default:
        break;
    }
  }

  void _markAsRead(int notificationId) {
    setState(() {
      final notification = _notifications.firstWhere(
        (n) => n['id'] == notificationId,
      );
      notification['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteNotification(int notificationId) {
    setState(() {
      _notifications.removeWhere((n) => n['id'] == notificationId);
    });
  }

  void _showNotificationSettings() {
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
              'Notification Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.volume_up_rounded,
                color: Color(0xFF667EEA),
              ),
              title: const Text('Push Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: const Color(0xFF667EEA),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.email_outlined,
                color: Color(0xFF10B981),
              ),
              title: const Text('Email Notifications'),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
                activeColor: const Color(0xFF667EEA),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.do_not_disturb_outlined,
                color: Color(0xFFF59E0B),
              ),
              title: const Text('Do Not Disturb'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.tune_rounded, color: Color(0xFF8B5CF6)),
              title: const Text('Advanced Settings'),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
