import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/pages/item_cart.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return Stack(
      children: [
        Image.asset(
          'lib/assets/images/detail_bg2_noshad.png',
          height: screenHeight,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              '',
              style: GoogleFonts.notoSans(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: screenHeight * 0.3,
                // color: blue,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    // 이미지 + 상품명
                    Container(
                      height: screenHeight * 0.35,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          // color: blue,
                          ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
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
                              style: GoogleFonts.notoSans(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF242424),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 이미지 아래 모든 콘텐츠를 감싸는 흰색 Container
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          // 가격 + 수량 선택
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.item.price == 0
                                      ? '무료'
                                      : '${NumberFormat('###,###').format(widget.item.price * quantity)}원',
                                  style: GoogleFonts.notoSans(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF242424)),
                                ),
                                Row(
                                  children: [
                                    _quantityButton(
                                        Icons.remove, _decreaseQuantity),
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
                                        style: GoogleFonts.notoSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF242424)),
                                      ),
                                    ),
                                    _quantityButton(
                                        Icons.add, _increaseQuantity),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 설명 영역
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('상품 상세',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: black3)),
                                const SizedBox(height: 6),
                                Container(
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    widget.item.description,
                                    style: GoogleFonts.notoSans(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50), // 하단 버튼 영역을 위해 충분한 여백 추가
                        ],
                      ),
                    ),
                  ],
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
                        child: Text('구매하기',
                            style: GoogleFonts.notoSans(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  // SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 8), // 가로 여백
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
        ),
      ],
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color(0xFF242424)),
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
        title: Text('좋은 선택이예요!',
            style: GoogleFonts.notoSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6B9DAD))),
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '\n ${widget.item.name}!! ',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '\n$quantity개 구매하시겠어요? ',
                style: GoogleFonts.notoSans(
                    fontSize: 18, color: black3, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('취소', style: GoogleFonts.notoSans(color: Colors.grey)),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            child: Text('확인',
                style: GoogleFonts.notoSans(
                    color: const Color(0xFFF28A98),
                    fontWeight: FontWeight.bold)),
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
          if (ctx.mounted) {
            if (Navigator.canPop(ctx)) Navigator.pop(ctx);
            if (Navigator.canPop(ctx)) Navigator.pop(ctx); // 리스트로!
          }
        });

        return CupertinoAlertDialog(
          title: Text('🎉 감사합니다! 🎉',
              style: GoogleFonts.notoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6B9DAD))),
          content: Text('\n구매가 완료되었습니다 🐙',
              style: GoogleFonts.notoSans(fontSize: 16)),
        );
      },
    );
  }

  /// ------------------------------------ ///
  /// ------- 장바구니 담기 관련 함수들!!  --------- ///
  ///
  void onConfirmAddToCart() {
    Provider.of<CartProvider>(context, listen: false)
        .addToCart(widget.item, quantity);
  }

  void _showAddToCartDialog(VoidCallback onConfirmAddToCart) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(
          '🛒 장바구니 담기 🛒',
          style: GoogleFonts.notoSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6B9DAD)),
        ),
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '\n ${widget.item.name}를 ',
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '\n장바구니에 담으시겠어요?',
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('취소', style: GoogleFonts.notoSans(color: Colors.grey)),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            child: Text('확인',
                style: GoogleFonts.notoSans(
                    color: const Color(0xFFF28A98),
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(ctx);
              Future.microtask(() {
                onConfirmAddToCart();
                _showCompleteDialogCart();
              });
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
        return CupertinoAlertDialog(
          title: Text('장바구니에 담겼습니다!',
              style: GoogleFonts.notoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6B9DAD))),
          content: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: '\n지금 확인해보세요 🛒',
                    style: GoogleFonts.notoSans(
                        fontSize: 16, color: const Color(0xFF242424))),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('장바구니로 가기 🚀',
                  style: GoogleFonts.notoSans(
                      color: const Color(0xFFF28A98),
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(ctx); // 다이얼로그 닫기
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => const ItemCart()),
                );
              },
            ),
            CupertinoDialogAction(
              child: Text('취소',
                  style: GoogleFonts.notoSans(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(ctx); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }
}
