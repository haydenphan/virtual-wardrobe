import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:virtual_wardrobe/model/product.model.dart';
import 'package:virtual_wardrobe/utils/constant.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: '$baseUrl/api',
    followRedirects: false,
  ),
);

Future<String> postImage(File image, String productId) async {
  return dio
      .post("/recognize",
          data: FormData.fromMap({
            "image": await MultipartFile.fromFile(
              image.path,
              filename: "image",
            ),
            productId: productId,
          }))
      .then((value) => value.data["image_url"]);
}

Future<File> takeStaticPicture(File image, String productId) async {
  // Read the image file as bytes

  if (image.existsSync()) {
    List<int> imageBytes = await image.readAsBytes();

    // Encode the image bytes as base64
    String base64Image = base64Encode(imageBytes);
    try {
      final data = {
        "image": base64Image,
        "product_id": productId,
      };
      Options options =
          Options(followRedirects: false, method: "POST", headers: {
        'Content-Type': 'application/json',
      });

      // Send the image to the server using a POST request
      Response response =
          await dio.post('/predict/', data: data, options: options);

      // Convert base64 to file
      final decodedBytes = base64Decode(response.data['data']);
      final file = File('${image.path}.jpg');
      await file.writeAsBytes(decodedBytes);

      return file;
    } catch (e) {
      // Handle errors
      print("Error: $e");
      throw e;
    }
  } else {
    print('anh null');
    throw Error();
  }
}

Future<List<Product>> getItems() async {
  final res = await dio.get("/items/").then((value) => value.data["data"]);
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
