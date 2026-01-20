// features/product/logic/product_event.dart
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductStarted extends ProductEvent {}
class ProductRefreshed extends ProductEvent {}