import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
// Import client package (tên package dựa theo ảnh bạn gửi)
import 'package:my_ecommerce_client/my_ecommerce_client.dart';

// Import các file feature (kiểm tra lại đường dẫn nếu bạn có thay đổi)
import 'features/product/data/product_repository.dart';
import 'features/product/logic/product_bloc.dart';
import 'features/product/ui/screens/product_list_screen.dart';

// 1. Khởi tạo Client kết nối với Serverpod
// Lưu ý:
// - Nếu chạy máy ảo Android: dùng 'http://10.0.2.2:8080/'
// - Nếu chạy iOS Simulator hoặc Web: dùng 'http://localhost:8080/'
var client = Client('http://10.0.2.2:8080/') // Đổi IP nếu cần
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      
      // 2. CẤU HÌNH DEPENDENCY INJECTION (QUAN TRỌNG)
      // RepositoryProvider: Cung cấp Repository (tầng Data) cho toàn bộ cây widget con
      home: RepositoryProvider(
        create: (context) => ProductRepository(client: client),
        
        // BlocProvider: Cung cấp BLoC (tầng Logic)
        child: BlocProvider(
          create: (context) {
            // Lấy Repository từ context ở trên để truyền vào BLoC
            final repository = context.read<ProductRepository>();
            return ProductBloc(repository: repository);
          },
          // Cuối cùng là màn hình UI
          child: const ProductListScreen(),
        ),
      ),
    );
  }
}