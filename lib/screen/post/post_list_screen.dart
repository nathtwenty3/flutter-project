import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pro_23/model/post_daa_model.dart';

import '../../controller/post_controller.dart';
import '../../main.dart';

class PostListScreenScreen extends StatelessWidget {
  const PostListScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());
    final TextEditingController searchController = TextEditingController();
    // final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Obx(() {
        // Loading
        // if (controller.isLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // Error
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        String formatDate(String? date) {
          if (date == null || date.isEmpty) {
            return 'Unknown';
          }

          try {
            final DateTime dateTime = DateTime.parse(date);

            return DateFormat('d MMM yyyy').format(dateTime);
          } catch (e) {
            return 'Unknown';
          }
        }

        return Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            //   child: TextField(
            //     controller: searchController,
            //     textInputAction: TextInputAction.search,
            //     onChanged: (value) {
            //       controller.searchTerm.value = value;
            //       controller.loadFirstPage();
            //     },
            //     decoration: InputDecoration(
            //       hintText: 'Search posts...',
            //       prefixIcon: const Icon(Icons.search),
            //       suffixIcon: searchController.text.isNotEmpty
            //           ? IconButton(
            //               onPressed: () {
            //                 searchController.clear();
            //               },
            //               icon: const Icon(Icons.clear),
            //             )
            //           : null,
            //       filled: true,
            //       fillColor: Colors.grey.shade100,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12.0),
            //         borderSide: BorderSide(color: Colors.grey, width: 1.5),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  controller.searchTerm.value = value;
                  controller.loadFirstPage();
                },
                decoration: InputDecoration(
                  hintText: 'Search posts...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (searchController.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            controller.searchTerm.value = '';
                            searchController.clear();
                            controller.loadFirstPage();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                    ],
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  '${controller.posts.length} of ${controller.total}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ),
            ),

            Expanded(
              child: Builder(
                builder: (context) {
                  // Empty
                  if (controller.posts.isEmpty) {
                    return const Center(child: Text('No posts found'));
                  }
                  //
                  // if (controller.isLoading.value) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }

                  return RefreshIndicator(
                    onRefresh: controller.loadFirstPage,
                    child: ListView.builder(
                      controller: controller.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          controller.posts.length +
                          (controller.isLoadingMore.value ? 1 : 0),

                      itemBuilder: (context, index) {
                        if (index >= controller.posts.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final Data post = controller.posts[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Post Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.network(
                                    post.imageUrl ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) {
                                      return Container(
                                        color: Colors.grey.shade100,
                                        child: const Icon(
                                          Icons.article_outlined,
                                          size: 20,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),
                              // Information
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.title ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      post.content ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            post.author?.nickName ?? 'Unknown',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ' - ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        Text(
                                          formatDate(post.createdAt),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey.shade600,
                                ),
                                onSelected: (String value) {
                                  if (value == 'edit') {
                                    print('Edit post ${post.id}');
                                  } else if (value == 'delete') {
                                    print('Delete post ${post.id}');
                                  }
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_outlined),
                                        SizedBox(width: 10),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'unpublish',
                                    child: Row(
                                      children: [
                                        Icon(Icons.visibility_off_outlined),
                                        SizedBox(width: 10),
                                        Text('Unpublish'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.toNamed('/post_form');
        },
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
