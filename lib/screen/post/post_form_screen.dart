import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pro_23/main.dart';
// import 'package:image_picker/image_picker.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // final ImagePicker _imagePicker = ImagePicker();
  //
  // XFile? selectedImage;

  bool published = true;
  bool isLoading = false;

  // =========================
  // PICK IMAGE
  // =========================

  // Future<void> pickImage() async {
  //   final XFile? image = await _imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 85,
  //   );
  //
  //   if (image == null) return;
  //
  //   setState(() {
  //     selectedImage = image;
  //   });
  // }

  // =========================
  // SAVE POST
  // =========================

  Future<void> savePost() async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter title')));

      return;
    }

    if (contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter content')));

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      print('Title: ${titleController.text}');
      print('Content: ${contentController.text}');
      print('Published: $published');
      // print('Image: ${selectedImage?.path}');

      // TODO:
      // Call your controller/repository here.
      //
      // Example:
      // await controller.createPost(
      //   title: titleController.text.trim(),
      //   content: contentController.text.trim(),
      //   published: published,
      //   image: selectedImage,
      // );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),

      appBar: AppBar(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xff1e293b)),
        ),

        title: const Text(
          'New post',
          style: TextStyle(
            color: Color(0xff1e293b),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // IMAGE
            // =========================
            GestureDetector(
              onTap: () async {
                // await pickImage();
              },
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xffe8f8f7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffd7e5e7)),
                ),
                // child: selectedImage != null
                //     ? ClipRRect(
                //         borderRadius: BorderRadius.circular(16),
                //         child: Image.file(
                //           File(selectedImage!.path),
                //           width: double.infinity,
                //           height: double.infinity,
                //           fit: BoxFit.cover,
                //         ),
                //       )
                //     : const Center(
                //         child: Icon(
                //           Icons.add_photo_alternate_outlined,
                //           size: 60,
                //           color: Color(0xff0dafaa),
                //         ),
                //       ),
              ),
            ),

            const SizedBox(height: 12),

            const Center(
              child: Text(
                '',
                style: TextStyle(fontSize: 14, color: Color(0xff94a3b8)),
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // TITLE
            // =========================
            const Text(
              'ចំណងជើង',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff64748b),
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'អត្ថបទរបស់អ្នក',
                hintStyle: const TextStyle(color: Color(0xff94a3b8)),

                prefixIcon: const Icon(Icons.title, color: Color(0xff64748b)),

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xffdbe3ea)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xffdbe3ea)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xff0dafaa),
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =========================
            // CONTENT
            // =========================
            const Text(
              'មាតិកា',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff64748b),
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: contentController,
              minLines: 7,
              maxLines: 10,
              textAlignVertical: TextAlignVertical.top,

              decoration: InputDecoration(
                hintText: 'សរសេរអ្វីមួយ...',
                hintStyle: const TextStyle(color: Color(0xff64748b)),

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.all(18),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xffdbe3ea)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xffdbe3ea)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xff0dafaa),
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // PUBLISH
            // =========================
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ចេញផ្សាយ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1e293b),
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'បើកដើម្បីបង្ហាញអត្ថបទនេះ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff94a3b8),
                        ),
                      ),
                    ],
                  ),
                ),

                Switch(
                  value: published,
                  activeTrackColor: const Color(0xff80d9d6),
                  activeThumbColor: const Color(0xff0dafaa),

                  onChanged: (value) {
                    setState(() {
                      published = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            // =========================
            // BUTTON
            // =========================
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : savePost,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0dafaa),
                  foregroundColor: Colors.white,

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 26),

                          SizedBox(width: 12),

                          Text(
                            'បង្កើតអត្ថបទ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
