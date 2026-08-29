import 'package:dio/dio.dart';
import 'package:pro_23/model/post_daa_model.dart';

class PostRepository {
  PostRepository();
  final Dio dio = Dio();

  Future<(PostDataModel?, String?)> getPageTest({
    int page = 0,
    int size = 10,
    String? title,
    bool? published,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        'https://flutter-api.janrent.com/api/posts',
        queryParameters: <String, dynamic>{
          'page': page,
          'size': size,
          'sortBy': 'createdAt',
          'direction': 'desc',

          if (title != null && title.isNotEmpty) 'title': title,

          'published': ?published,
        },
      );

      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      print("Repository");
      print(response);
      return (PostDataModel.fromJson(json), null);
    } catch (e) {
      return (null, e.toString());
    }
  }
}
