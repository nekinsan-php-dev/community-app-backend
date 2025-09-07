import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _pollQuestionController = TextEditingController();
  final List<TextEditingController> _pollOptionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  String _selectedAudience = 'Public';
  bool _allowComments = true;
  bool _isAnonymous = false;
  List<String> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
              children: [
                _buildTextPostTab(),
                _buildPollTab(),
                _buildImageTab(),
                _buildVideoTab(),
              ],
            ),
          ),
          _buildBottomActions(),
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
        icon: const Icon(Icons.close_rounded, color: Color(0xFF374151)),
      ),
      title: const Text(
        'Create Post',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: ElevatedButton(
            onPressed: _canPost() ? _publishPost : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667EEA),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Post',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
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
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        tabs: const [
          Tab(icon: Icon(Icons.text_fields_rounded), text: 'Text'),
          Tab(icon: Icon(Icons.poll_rounded), text: 'Poll'),
          Tab(icon: Icon(Icons.image_rounded), text: 'Image'),
          Tab(icon: Icon(Icons.videocam_rounded), text: 'Video'),
        ],
      ),
    );
  }

  Widget _buildTextPostTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(),
          const SizedBox(height: 16),
          _buildTextInput(),
          const SizedBox(height: 24),
          _buildPostOptions(),
        ],
      ),
    );
  }

  Widget _buildPollTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(),
          const SizedBox(height: 16),
          _buildPollQuestion(),
          const SizedBox(height: 16),
          _buildPollOptions(),
          const SizedBox(height: 16),
          _buildAddPollOption(),
          const SizedBox(height: 24),
          _buildPollSettings(),
          const SizedBox(height: 24),
          _buildPostOptions(),
        ],
      ),
    );
  }

  Widget _buildImageTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(),
          const SizedBox(height: 16),
          _buildImageSelector(),
          const SizedBox(height: 16),
          _buildTextInput(hintText: 'Write a caption...'),
          const SizedBox(height: 24),
          _buildPostOptions(),
        ],
      ),
    );
  }

  Widget _buildVideoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(),
          const SizedBox(height: 16),
          _buildVideoSelector(),
          const SizedBox(height: 16),
          _buildTextInput(hintText: 'Write a description...'),
          const SizedBox(height: 24),
          _buildPostOptions(),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF667EEA),
            child: Text(
              'RK',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rajesh Kumar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  'Party Worker • Delhi',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildAudienceSelector(),
        ],
      ),
    );
  }

  Widget _buildAudienceSelector() {
    return PopupMenuButton<String>(
      initialValue: _selectedAudience,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF667EEA).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF667EEA).withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _selectedAudience == 'Public' ? Icons.public : Icons.group,
              size: 16,
              color: const Color(0xFF667EEA),
            ),
            const SizedBox(width: 4),
            Text(
              _selectedAudience,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF667EEA),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: Color(0xFF667EEA),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'Public',
          child: Row(
            children: [
              Icon(Icons.public, size: 18),
              SizedBox(width: 8),
              Text('Public'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'Followers',
          child: Row(
            children: [
              Icon(Icons.group, size: 18),
              SizedBox(width: 8),
              Text('Followers Only'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'Private',
          child: Row(
            children: [
              Icon(Icons.lock, size: 18),
              SizedBox(width: 8),
              Text('Private'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        setState(() {
          _selectedAudience = value;
        });
      },
    );
  }

  Widget _buildTextInput({String? hintText}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _textController,
        maxLines: 8,
        decoration: InputDecoration(
          hintText: hintText ?? 'What\'s happening in your community?',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildPollQuestion() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _pollQuestionController,
        decoration: InputDecoration(
          hintText: 'Ask a question...',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: const Icon(
            Icons.help_outline_rounded,
            color: Color(0xFF667EEA),
          ),
        ),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildPollOptions() {
    return Column(
      children: _pollOptionControllers.asMap().entries.map((entry) {
        int index = entry.key;
        TextEditingController controller = entry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Option ${index + 1}',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: CircleAvatar(
                radius: 8,
                backgroundColor: const Color(0xFF667EEA).withOpacity(0.2),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF667EEA),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              suffixIcon: _pollOptionControllers.length > 2
                  ? IconButton(
                      onPressed: () => _removePollOption(index),
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    )
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddPollOption() {
    if (_pollOptionControllers.length >= 5) return const SizedBox.shrink();

    return InkWell(
      onTap: _addPollOption,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF667EEA).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: Color(0xFF667EEA), size: 20),
            SizedBox(width: 8),
            Text(
              'Add Option',
              style: TextStyle(
                color: Color(0xFF667EEA),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          const Text(
            'Poll Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                color: Color(0xFF667EEA),
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Poll Duration',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              DropdownButton<String>(
                value: '7 days',
                underline: const SizedBox.shrink(),
                items: const [
                  DropdownMenuItem(value: '1 day', child: Text('1 day')),
                  DropdownMenuItem(value: '3 days', child: Text('3 days')),
                  DropdownMenuItem(value: '7 days', child: Text('7 days')),
                  DropdownMenuItem(value: '30 days', child: Text('30 days')),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.visibility_outlined,
                color: Color(0xFF667EEA),
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Anonymous Poll',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Switch(
                value: _isAnonymous,
                onChanged: (value) {
                  setState(() {
                    _isAnonymous = value;
                  });
                },
                activeColor: const Color(0xFF667EEA),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageSelector() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
      ),
      child: _selectedImages.isEmpty
          ? InkWell(
              onTap: _selectImages,
              borderRadius: BorderRadius.circular(12),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 48,
                      color: Color(0xFF667EEA),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add Photos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF667EEA),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap to select up to 10 photos',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _selectedImages.length + 1,
              itemBuilder: (context, index) {
                if (index == _selectedImages.length) {
                  return InkWell(
                    onTap: _selectImages,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Color(0xFF667EEA),
                      ),
                    ),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildVideoSelector() {
    return InkWell(
      onTap: _selectVideo,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam_rounded, size: 48, color: Color(0xFF667EEA)),
              SizedBox(height: 8),
              Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF667EEA),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Record or select a video',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          const Text(
            'Post Options',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.comment_outlined,
                color: Color(0xFF667EEA),
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Allow Comments',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Switch(
                value: _allowComments,
                onChanged: (value) {
                  setState(() {
                    _allowComments = value;
                  });
                },
                activeColor: const Color(0xFF667EEA),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tag_rounded, color: Colors.grey),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.location_on_outlined, color: Colors.grey),
            ),
            const Spacer(),
            Text(
              '${_getCharacterCount()}/500',
              style: TextStyle(
                fontSize: 12,
                color: _getCharacterCount() > 450
                    ? Colors.red
                    : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addPollOption() {
    if (_pollOptionControllers.length < 5) {
      setState(() {
        _pollOptionControllers.add(TextEditingController());
      });
    }
  }

  void _removePollOption(int index) {
    if (_pollOptionControllers.length > 2) {
      setState(() {
        _pollOptionControllers[index].dispose();
        _pollOptionControllers.removeAt(index);
      });
    }
  }

  void _selectImages() {
    // Implement image selection
    setState(() {
      _selectedImages.add('image_${_selectedImages.length + 1}');
    });
  }

  void _selectVideo() {
    // Implement video selection
  }

  bool _canPost() {
    switch (_tabController.index) {
      case 0: // Text
        return _textController.text.trim().isNotEmpty;
      case 1: // Poll
        return _pollQuestionController.text.trim().isNotEmpty &&
            _pollOptionControllers
                    .where((c) => c.text.trim().isNotEmpty)
                    .length >=
                2;
      case 2: // Image
        return _selectedImages.isNotEmpty;
      case 3: // Video
        return true; // Would check if video is selected
      default:
        return false;
    }
  }

  int _getCharacterCount() {
    return _textController.text.length;
  }

  void _publishPost() {
    // Implement post publishing logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post published successfully!'),
        backgroundColor: Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    _pollQuestionController.dispose();
    for (var controller in _pollOptionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
