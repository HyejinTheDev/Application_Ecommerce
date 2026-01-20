import 'package:flutter/material.dart';
import 'package:my_ecommerce_client/my_ecommerce_client.dart'; // Import model Product từ client

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        // Giả sử model Product có trường 'image', 'name', 'price'
        // Nếu chưa có ảnh thật thì dùng Icon thay thế tạm
        leading: Container(
          width: 50, 
          height: 50,
          color: Colors.grey[200],
          child: const Icon(Icons.image), 
          // Sau này thay bằng: Image.network(product.imageUrl ?? '')
        ),
        title: Text(
          product.name ?? 'Sản phẩm chưa có tên',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${product.price} đ', // Format tiền tệ sau này tính sau
          style: const TextStyle(color: Colors.green),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            // Logic thêm vào giỏ hàng sẽ viết ở đây
          },
        ),
      ),
    );
  }
}