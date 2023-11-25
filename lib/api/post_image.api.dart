import 'dart:html';

import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:5000/api',
  ),
);


Future<String> postImage(File image) async {
  return dio.post("/image", data: FormData.fromMap({
    "image": await MultipartFile.fromFile(
      image.relativePath ?? image.name,
      filename: "image",
    ),
  })).then((value) => value.data["image_url"]);
}