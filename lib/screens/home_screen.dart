import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      'id': 1,
      'type': 'poll',
      'userName': 'Delhi Youth Wing',
      'userAvatar': 'https://via.placeholder.com/40',
      'userRole': 'Official',
      'timeAgo': '2 hours ago',
      'verified': true,
      'content':
          'What should be our top priority for the upcoming budget session?',
      'pollOptions': [
        {'text': 'Healthcare Infrastructure', 'votes': 234, 'percentage': 45},
        {'text': 'Education Reform', 'votes': 156, 'percentage': 30},
        {'text': 'Public Transportation', 'votes': 89, 'percentage': 17},
        {'text': 'Digital Governance', 'votes': 42, 'percentage': 8},
      ],
      'totalVotes': 521,
      'userVoted': false,
      'likes': 89,
      'comments': 34,
      'shares': 12,
      'isLiked': false,
    },
    {
      'id': 2,
      'type': 'image',
      'userName': 'Rajesh Kumar',
      'userAvatar': 'https://via.placeholder.com/40',
      'userRole': 'Party Worker',
      'timeAgo': '4 hours ago',
      'verified': false,
      'content':
          'Amazing turnout at today\'s community rally! The energy and enthusiasm of our supporters is truly inspiring. Together we can build a better future! 🙌',
      'image': 'https://via.placeholder.com/400x250',
      'likes': 156,
      'comments': 28,
      'shares': 45,
      'isLiked': true,
    },
    {
      'id': 3,
      'type': 'video',
      'userName': 'Priya Sharma',
      'userAvatar': 'https://via.placeholder.com/40',
      'userRole': 'Volunteer Coordinator',
      'timeAgo': '6 hours ago',
      'verified': true,
      'content':
          'Live from the voter registration drive! See how our volunteers are making democracy accessible to everyone.',
      'videoThumbnail': 'https://via.placeholder.com/400x250',
      'videoDuration': '2:34',
      'likes': 203,
      'comments': 67,
      'shares': 89,
      'isLiked': false,
    },
    {
      'id': 4,
      'type': 'text',
      'userName': 'Community Updates',
      'userAvatar': 'https://via.placeholder.com/40',
      'userRole': 'Official',
      'timeAgo': '8 hours ago',
      'verified': true,
      'content':
          'ANNOUNCEMENT: New policy proposal for senior citizen welfare has been submitted to the committee. We\'ve included provisions for:\n\n• Free health checkups\n• Transportation subsidies\n• Digital literacy programs\n• Pension scheme improvements\n\nYour feedback matters! Let us know your thoughts in the comments.',
      'likes': 298,
      'comments': 156,
      'shares': 78,
      'isLiked': false,
    },
    {
      'id': 5,
      'type': 'poll',
      'userName': 'Amit Singh',
      'userAvatar': 'https://via.placeholder.com/40',
      'userRole': 'Local Leader',
      'timeAgo': '12 hours ago',
      'verified': false,
      'content': 'Quick poll: What time works best for community meetings?',
      'pollOptions': [
        {'text': '6:00 PM - 7:00 PM', 'votes': 89, 'percentage': 52},
        {'text': '7:00 PM - 8:00 PM', 'votes': 67, 'percentage': 39},
        {'text': 'Weekend mornings', 'votes': 15, 'percentage': 9},
      ],
      'totalVotes': 171,
      'userVoted': true,
      'userVotedOption': 0,
      'likes': 23,
      'comments': 8,
      'shares': 5,
      'isLiked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Share your thoughts with the community...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildPostCard(_posts[index]),
                childCount: _posts.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/new_post');
        },
        backgroundColor: const Color(0xFF667EEA),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Create',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(post),
          _buildPostContent(post),
          _buildPostActions(post),
        ],
      ),
    );
  }

  Widget _buildPostHeader(Map<String, dynamic> post) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFF667EEA),
                child: Text(
                  post['userName'][0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              if (post['verified'])
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
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post['userName'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    if (post['verified']) const SizedBox(width: 4),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getRoleColor(post['userRole']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        post['userRole'],
                        style: TextStyle(
                          fontSize: 12,
                          color: _getRoleColor(post['userRole']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post['timeAgo'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent(Map<String, dynamic> post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post['content'] != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post['content'],
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF374151),
                height: 1.5,
              ),
            ),
          ),

        if (post['type'] == 'poll') ...[
          const SizedBox(height: 16),
          _buildPollContent(post),
        ],

        if (post['type'] == 'image') ...[
          const SizedBox(height: 12),
          _buildImageContent(post),
        ],

        if (post['type'] == 'video') ...[
          const SizedBox(height: 12),
          _buildVideoContent(post),
        ],

        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildPollContent(Map<String, dynamic> post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ...post['pollOptions'].asMap().entries.map((entry) {
            int index = entry.key;
            var option = entry.value;
            bool isSelected =
                post['userVoted'] && post['userVotedOption'] == index;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: post['userVoted']
                    ? null
                    : () {
                        setState(() {
                          post['userVoted'] = true;
                          post['userVotedOption'] = index;
                        });
                      },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF667EEA).withOpacity(0.1)
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF667EEA)
                          : Colors.grey[200]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option['text'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF667EEA)
                                : const Color(0xFF374151),
                          ),
                        ),
                      ),
                      if (post['userVoted'])
                        Text(
                          '${option['percentage']}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 8),
          Text(
            '${post['totalVotes']} votes',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent(Map<String, dynamic> post) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoContent(Map<String, dynamic> post) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.grey[300],
              child: const Icon(
                Icons.play_circle_fill,
                size: 60,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  post['videoDuration'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostActions(Map<String, dynamic> post) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (post['likes'] > 0) ...[
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF667EEA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.thumb_up,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${post['likes']}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const Spacer(),
              if (post['comments'] > 0)
                Text(
                  '${post['comments']} comments',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              if (post['shares'] > 0) ...[
                const SizedBox(width: 12),
                Text(
                  '${post['shares']} shares',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: post['isLiked']
                      ? Icons.thumb_up
                      : Icons.thumb_up_outlined,
                  label: 'Like',
                  isActive: post['isLiked'],
                  onTap: () {
                    setState(() {
                      post['isLiked'] = !post['isLiked'];
                      if (post['isLiked']) {
                        post['likes']++;
                      } else {
                        post['likes']--;
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comment',
                  onTap: () {},
                ),
              ),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? const Color(0xFF667EEA) : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? const Color(0xFF667EEA) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'official':
        return const Color(0xFF059669);
      case 'party worker':
        return const Color(0xFF7C3AED);
      case 'volunteer coordinator':
      case 'volunteer':
        return const Color(0xFFEA580C);
      case 'local leader':
        return const Color(0xFFDC2626);
      default:
        return const Color(0xFF6B7280);
    }
  }
}
