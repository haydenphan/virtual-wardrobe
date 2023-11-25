import 'dart:io';
import 'package:dio/dio.dart';
import 'package:virtual_wardrobe/model/product.model.dart';
import 'package:virtual_wardrobe/utils/constant.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: '$baseUrl/api',
  ),
);


Future<String> postImage(File image, String productId) async {
  return dio.post("/recognize", data: FormData.fromMap({
    "image": await MultipartFile.fromFile(
      image.path,
      filename: "image",
    ),
    productId: productId,
  })).then((value) => value.data["image_url"]);
}

Future<List<Product>> getItems() async {
  final res = await dio.get("/items").then((value) => value.data["data"]);
  final List<Product> products = [];
  res.forEach((element) {
    products.add(Product.fromJson(element));
  });

  return products;
}

Future<Product> getItem(String id) async {
  final res = await dio.get("/items/$id").then((value) => value.data["data"]);
  return Product.fromJson(res);
}