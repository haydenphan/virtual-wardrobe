import 'dart:io';
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:5000/api',
  ),
);


Future<String> postImage(File image, String productId) async {
  return dio.post("/image", data: FormData.fromMap({
    "image": await MultipartFile.fromFile(
      image.path,
      filename: "image",
    ),
    productId: productId,
  })).then((value) => value.data["image_url"]);
}