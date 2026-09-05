import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/controller/home_controller.dart';
import '../../main.dart';

import 'package:pro_23/model/slider_model.dart';
import 'package:pro_23/model/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white, // set to any color you want
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              accountName: Text("Neng Phanath".tr),
              accountEmail: Text(
                "nath@example.com",
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "AD",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('users'.tr),
            ),
            ListTile(
              leading: Icon(Icons.person_add_alt_outlined),
              title: Text('new_user'.tr),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.translate),
              title: Text('language'.tr),
              trailing: Text(
                'english'.tr,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                if (Get.locale?.languageCode == 'en') {
                  Get.updateLocale(Locale('km', 'en'));
                } else {
                  Get.updateLocale(Locale('en', 'US'));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.signal_cellular_alt),
              title: Text('connection'.tr),
              trailing: Text(
                'Online',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('logout'.tr, style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          // =========================
          // Loading
          // =========================
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 20, top: 20),

            children: <Widget>[
              // =========================
              // Carousel
              // =========================
              CarouselSlider(
                items: controller.banners.map((SliderModel banner) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.greenAccent,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        // =========================
                        // Image
                        // =========================
                        Image.network(
                          banner.fullImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) {
                            return const Icon(
                              Icons.image_not_supported_outlined,
                              size: 40,
                            );
                          },
                        ),

                        // =========================
                        // Dark Overlay
                        // =========================
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.transparent,
                                Colors.black54,
                              ],
                            ),
                          ),
                        ),

                        // =========================
                        // Banner Text
                        // =========================
                        Positioned(
                          left: 16,
                          right: 16,
                          bottom: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                banner.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              if (banner.subtitle != null &&
                                  banner.subtitle!.isNotEmpty)
                                Text(
                                  banner.subtitle!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                options: CarouselOptions(
                  height: 190,
                  viewportFraction: 0.88,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: true,
                ),
              ),

              const SizedBox(height: 24),

              // =========================
              // Latest Posts Title
              // =========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'latest_posts'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // =========================
              // Post List
              // =========================
              ...controller.latestPosts.map((PostModel post) {
                final String url = post.fullImageUrl;

                return Card(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        // =========================
                        // Post Image
                        // =========================
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) {
                                return const ColoredBox(
                                  color: Colors.greenAccent,
                                  child: Icon(Icons.article_outlined),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // =========================
                        // Post Information
                        // =========================
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                post.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 4),

                              Text(
                                post.author?.displayName ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
