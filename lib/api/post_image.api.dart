import 'dart:io';
import 'package:dio/dio.dart';
import 'package:virtual_wardrobe/model/product.model.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://172.16.255.213:5000/api',
  ),
);


Future<String> postImage(File image, String productId) async {
  return dio.post("/items", data: FormData.fromMap({
    "image": await MultipartFile.fromFile(
      image.path,
      filename: "image",
    ),
    productId: productId,
  })).then((value) => value.data["image_url"]);
}

Future<List<Product>> getItems() async {
  final res= await dio.get("/items").then((value) => value.data["data"]);
  final List<Product> products = [];
  res.forEach((element) {
    products.add(Product.fromJson(element));
  });

  return products;
}