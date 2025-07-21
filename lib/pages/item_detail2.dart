import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart_provider.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                            decoration: const BoxDecoration(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 8), //가로 여백
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
                    child: const Text('Order Now',
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
                  margin: const EdgeInsets.symmetric(horizontal: 8), // 가로 여백
                  child: ElevatedButton(
                    onPressed: () {
                      _showAddToCartDialog(() {
                        final cart = Provider.of<CartProvider>(context,
                            listen:
                                false); // 이 버튼은 cartprovider의 상태 변화에 상관없이 동일한 모습이므로, 다시 build되지 않게 listen: false로 설정했습니당
                        cart.addToCart(widget.item, quantity);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.shopping_cart_outlined,
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

  /// ------------------------------------ ///
  /// ------- 구매하기 관련 함수들!!  --------- ///
  void _showPurchaseDialog() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Confirm purchase:',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B9DAD))),
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '\nAre you sure you want to buy\n ',
                style: TextStyle(
                    fontSize: 16, color: black3, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '${quantity} * ${widget.item.name}?',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child:
                const Text('Maybe later', style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            child: const Text('Let’s do it!!',
                style: TextStyle(
                    color: Color(0xFFF28A98), fontWeight: FontWeight.bold)),
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
          if (Navigator.canPop(ctx)) Navigator.pop(ctx); // 리스트로!
        });
        return const CupertinoAlertDialog(
          title: Text('🎉 Thank you! 🎉',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B9DAD))),
          content: Text('Your purchase is complete ',
              style: TextStyle(fontSize: 16)),
        );
      },
    );
  }

  /// ------------------------------------ ///
  /// ------- 장바구니 담기 관련 함수들!!  --------- ///
  void _showAddToCartDialog(VoidCallback onConfirmAddToCart) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(
          'Add to cart 🛒',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B9DAD)),
        ),
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${quantity} * ${widget.item.name}\n\n',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: 'Sounds good to add this to your cart?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Not now', style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            child: const Text('Yep!',
                style: TextStyle(
                    color: Color(0xFFF28A98), fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(ctx);
              onConfirmAddToCart();
              _showCompleteDialogCart();
            },
          ),
        ],
      ),
    );
  }

  void _showCompleteDialogCart() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        Future.delayed(const Duration(seconds: 1), () {
          if (Navigator.canPop(ctx)) Navigator.pop(ctx);
          if (Navigator.canPop(ctx)) Navigator.pop(ctx); // 리스트로!
        });
        return const CupertinoAlertDialog(
          title: Text('🎉 Yayyy 🎉',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B9DAD))),
          content: Text('Added to your cart!', style: TextStyle(fontSize: 16)),
        );
      },
    );
  }
}
