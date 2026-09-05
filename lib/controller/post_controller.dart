import 'package:get/get.dart';
import 'package:pro_23/model/post_daa_model.dart';
import 'package:pro_23/repository/post_repository.dart';
import 'package:flutter/material.dart';

class PostController extends GetxController {
  final PostRepository _postRepo = Get.put(PostRepository());
  final PostRepository postRepository = PostRepository();
  final ScrollController scrollController = ScrollController(); //new

  final posts = <Data>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;
  final searchTerm = ''.obs;

  int _page = 0;
  int _totalPages = 10;
  int _total = 0;

  int get total => _total;

  bool get hasMore => _page + 1 < _totalPages;

  @override
  void onInit() {
    super.onInit();

    // new
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        loadMore();
      }
    });

    loadFirstPage();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadFirstPage() async {
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    _page = 0;

    final (PostDataModel? page, String? error) = await _postRepo.getPageTest(
      page: 0,
      size: 10,
      title: searchTerm.value,
    );

    isLoading.value = false;

    // Error
    if (error != null) {
      errorMessage.value = error;
      posts.clear();
      return;
    }

    // No response
    if (page == null) {
      errorMessage.value = 'No data';
      posts.clear();
      return;
    }

    // Replace old data
    posts.assignAll((page.data ?? []) as Iterable<Data>);

    // Update pagination metadata
    _applyMeta(page);
  }

  Future<void> loadMore() async {
    // Don't load if already loading.
    if (isLoadingMore.value) return;

    // Don't load if there are no more pages.
    if (!hasMore) return;

    isLoadingMore.value = true;

    errorMessage.value = '';

    try {
      final int nextPage = _page + 1;

      final (PostDataModel? page, String? error) = await _postRepo.getPageTest(
        page: nextPage,
        size: 10,
        title: searchTerm.value,
      );

      if (error != null) {
        errorMessage.value = error;
        return;
      }

      if (page == null) {
        return;
      }

      // Add new posts instead of replacing old posts.
      posts.addAll(page.data ?? []);

      // Update pagination.
      _applyMeta(page);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  void _applyMeta(PostDataModel page) {
    final Pagination? pagination = page.pagination;

    if (pagination == null) {
      _total = 0;
      _totalPages = 1;
      return;
    }

    _page = pagination.page ?? 0;
    _totalPages = pagination.totalPages ?? 1;
    _total = pagination.total ?? 0;

    print(
      'Pagination: '
      'page=$_page, '
      'totalPages=$_totalPages, '
      'total=$_total',
    );
  }
}
