import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ProductEndpoint extends Endpoint {
  // Hàm lấy danh sách sản phẩm
  Future<List<Product>> getAllProducts(Session session) async {
    return await Product.db.find(session);
  }

  // Hàm thêm sản phẩm mẫu
  Future<void> addSampleProduct(Session session, Product product) async {
    await Product.db.insertRow(session, product);
  }
}