// lib/models/item.dart

class Item {
  final String id; // 상품 고유 ID
  final String name; // 상품 이름
  final String description; // 상품 설명
  final String imagePath; // 상품 이미지 경로 (assets/images/xxx.jpg)
  final int price; // 상품 가격
  int quantity; // 장바구니에 담긴 수량 (기본값은 1)

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    this.quantity = 1, // 장바구니에 담길 때 기본 수량은 1
  });

// 장바구니에서 복사할 때 사용할 수 있도록 copyWith 메서드 추가
  /// copyWith 메서드는 객체의 일부 속성만 변경하고 나머지는 그대로 유지할 수 있게 해준당
  /// 예를 들어, 장바구니에서 수량만 변경하고 싶을 때 유용함!
  Item copyWith({
    String? id,
    String? name,
    String? description,
    String? imagePath,
    int? price,
    int? quantity,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
