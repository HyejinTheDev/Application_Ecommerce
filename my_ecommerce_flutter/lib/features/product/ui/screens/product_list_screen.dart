import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. IMPORT CÁC FILE LOGIC (Quan trọng để hiểu state)
import '../../logic/product_bloc.dart';
import '../../logic/product_event.dart';
import '../../logic/product_state.dart';

// 2. IMPORT CÁC FILE WIDGET CON
import '../widgets/product_card.dart';
import '../widgets/product_loading_shimmer.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Kích hoạt event load dữ liệu ngay khi màn hình mở lên
    // context.read giúp tìm BLoC đã được cung cấp từ main.dart
    context.read<ProductBloc>().add(ProductStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Nút refresh thủ công để test load lại dữ liệu
              context.read<ProductBloc>().add(ProductRefreshed());
            },
          ),
        ],
      ),
      // BlocBuilder lắng nghe thay đổi từ ProductBloc
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text('Lỗi: ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(ProductStarted());
                      },
                      child: const Text('Thử lại'),
                    )
                  ],
                ),
              );

            case ProductStatus.success:
              if (state.products.isEmpty) {
                return const Center(child: Text('Chưa có sản phẩm nào'));
              }
              // Hiển thị danh sách dạng lưới (Grid) hoặc dọc (List)
              // Ở đây dùng ListView cho đơn giản
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: state.products[index]);
                },
              );

            case ProductStatus.loading:
            case ProductStatus.initial:
            default:
              // Hiển thị hiệu ứng loading khi đang tải
              return const ProductLoadingShimmer();
          }
        },
      ),
    );
  }
}