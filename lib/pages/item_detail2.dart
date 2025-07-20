import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
// import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// import '../models/cart_provider.dart';

class ItemDetail2 extends StatefulWidget {
  final Item item;

  const ItemDetail2({super.key, required this.item});

  @override
  State<ItemDetail2> createState() => _ItemDetail2State();
}

class _ItemDetail2State extends State<ItemDetail2> {
  int quantity = 1;
  late Color lightBlue;
  late Color skyBlue;
  late Color blue;
  late Color black3;

  @override
  Widget build(BuildContext context) {
    // 색상 관련 설정
    lightBlue = Theme.of(context).colorScheme.primary;
    skyBlue = Theme.of(context).colorScheme.secondary;
    blue = Theme.of(context).colorScheme.tertiary;
    black3 = Theme.of(context).colorScheme.onSurface;

    // 화면 크기 가져오기
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blue,
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // 이미지 + 상품명
          Container(
            height: screenHeight * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: blue,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  'lib/assets/images/background_reverse.png',
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  widget.item.imagePath,
                  height: screenHeight * 0.3,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.item.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242424),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 가격 + 수량 선택
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${NumberFormat('#,##0.00').format(widget.item.price * quantity)}',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242424)),
                ),
                Row(
                  children: [
                    _quantityButton(Icons.remove, _decreaseQuantity),
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF242424)),
                      ),
                    ),
                    _quantityButton(Icons.add, _increaseQuantity),
                  ],
                ),
              ],
            ),
          ),

          // 설명 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: black3)),
                const SizedBox(height: 6),
                Container(
                  height: screenHeight * 0.25,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 3,
                        offset: const Offset(0, -2),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Text(
                          widget.item.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        height: screenHeight * 0.05,
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white12,
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // 하단 네비게이션 바
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom + 3,
        ),
        child: Container(
          height: 85,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 8), //오른쪽 여백
                  child: ElevatedButton(
                    onPressed: () {
                      _showPurchaseDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text('Order Now',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              // SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 8), // 왼쪽 여백
                  child: ElevatedButton(
                    onPressed: () {
                      // 장바구니에 추가 로직
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(12),
                    ),
                    child: Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Color(0xFF242424)),
    );
  }

  void _increaseQuantity() {
    if (quantity < 99) setState(() => quantity++);
  }

  void _decreaseQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  void _showPurchaseDialog() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('구매 확인'),
        content: Text('${widget.item.name} ${quantity}개 구매하시겠어요?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소', style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            child: const Text('확인', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(ctx);
              _showCompleteDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showCompleteDialog() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        Future.delayed(const Duration(seconds: 1), () {
          if (Navigator.canPop(ctx)) Navigator.pop(ctx);
        });
        return const CupertinoAlertDialog(
          title: Text('🎉 구매 완료 🎉'),
          content: Text('감사합니다!'),
        );
      },
    );
  }
}

//뀨뀨
