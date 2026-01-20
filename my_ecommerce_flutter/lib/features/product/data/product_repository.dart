// features/product/data/product_repository.dart
import 'package:my_ecommerce_client/my_ecommerce_client.dart'; // Import package client

class ProductRepository {
  final Client client;

  ProductRepository({required this.client});

  Future<List<Product>> getProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Giả lập delay

      // TRẢ VỀ DATA GIẢ (Đã thêm imageUrl và createdDate)
      return [
        Product(
          id: 1,
          name: 'Áo Thun Basic',
          price: 150000,
          description: 'Áo thun cotton thoáng mát',
          imageUrl: 'https://via.placeholder.com/150', // Link ảnh mẫu
          createdDate: DateTime.now(), // Thời gian hiện tại
        ),
        Product(
          id: 2,
          name: 'Quần Jean Nam',
          price: 350000,
          description: 'Quần jean phong cách trẻ trung',
          imageUrl: 'https://via.placeholder.com/150',
          createdDate: DateTime.now(),
        ),
        Product(
          id: 3,
          name: 'Giày Sneaker',
          price: 1200000,
          description: 'Giày thể thao êm ái',
          imageUrl: 'https://via.placeholder.com/150',
          createdDate: DateTime.now(),
        ),
        Product(
          id: 4,
          name: 'Balo Laptop',
          price: 450000,
          description: 'Chống nước, chống sốc',
          imageUrl: 'https://via.placeholder.com/150',
          createdDate: DateTime.now(),
        ),
      ];

    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }
}