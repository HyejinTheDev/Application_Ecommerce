// features/product/logic/product_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce_client/my_ecommerce_client.dart'; // Nhớ sửa package này
import '../data/product_repository.dart';

// Import 2 file kia vào thay vì dùng part
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _repository;

  ProductBloc({required ProductRepository repository})
      : _repository = repository,
        super(const ProductState()) {
    on<ProductStarted>(_onStarted);
    on<ProductRefreshed>(_onRefreshed);
  }

  Future<void> _onStarted(ProductStarted event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await _repository.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshed(ProductRefreshed event, Emitter<ProductState> emit) async {
    add(ProductStarted());
  }
}