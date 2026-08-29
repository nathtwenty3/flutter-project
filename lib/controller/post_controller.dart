import 'package:get/get.dart';
import 'package:pro_23/model/post_daa_model.dart';
import 'package:pro_23/repository/post_repository.dart';

class PostController extends GetxController {
  final PostRepository _postRepo = Get.put(PostRepository());
  final PostRepository postRepository = PostRepository();

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
    loadFirstPage();
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
