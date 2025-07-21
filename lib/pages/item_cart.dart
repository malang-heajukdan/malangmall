import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../styles/app_colors.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({super.key});

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }

  @override //화면구성
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    final bool isCartEmpty = cartItems.isEmpty;
    final screenHeight = MediaQuery.of(context).size.height;

    // // 총 가격 계산 함수
    // int getTotalPrice() {
    //  return cartItems.fold(
    //         0, (sum, e) => sum + (e.item.price * e.quantity));
    //          }

    return Stack(
      children: [
        Image.asset(
          'lib/assets/images/cart_bg.png',
          height: screenHeight,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // 상단 AppBar 만들기
          appBar: AppBar(
            title: Text(
              '장바구니',
              style: GoogleFonts.notoSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface, // 커스텀 컬러 사용
              ),
            ),

            actions: [
              IconButton(
                icon: const Icon(
                  Icons.home_outlined,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/list'); // 장바구니 페이지 이동
                },
                color: AppColors.onSurface,
              ),
            ],
            backgroundColor: Colors.transparent, // 커스텀 컬러 사용
          ),

          body: isCartEmpty
              ? Center(
                  child: Text(
                    '장바구니가 비었습니다.',
                    style: GoogleFonts.notoSans(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];

                          return Container(
                            // 카드 스타일

                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xFFD3E6EC), width: 2.5),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 상품 이미지

                                Padding(
                                  // 이미지 불러오기 방법1
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.asset(
                                      // 'lib/assets/images/octopus.png',
                                      cartItem.item.imagePath,
                                      fit: BoxFit
                                          .cover, // 또는 contain, fill 등도 사용 가능
                                    ),
                                  ),
                                ),

                                // Container( // 이미지 불러오기 방법2
                                //   width: 120,
                                //   height: 120,
                                //   decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //       image:
                                //           AssetImage('assets/images/octopus.png'),
                                //       fit: BoxFit.cover,
                                //     ),
                                //     borderRadius: BorderRadius.circular(8),
                                //   ),
                                // ),

                                const SizedBox(width: 12),
                                Expanded(
                                  //중간
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem.item.name,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${_formatPrice(cartItem.item.price)}원',
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF95C5D4)),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  //오른쪽
                                  //삭제버튼
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cartProvider
                                            .removeFromCart(cartItem.item.id);
                                      },
                                      icon: const Icon(Icons.clear,
                                          color: Color(0xFF95C5D4)),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (cartItem.quantity > 1) {
                                              cartProvider.updateQuantity(
                                                  cartItem.item.id,
                                                  cartItem.quantity - 1);
                                              // cartItem.quantity--;
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Color(0xff95C5D4),
                                            size: 40,
                                          ),
                                        ),
                                        Text(
                                          '${cartItem.quantity}',
                                          style: GoogleFonts.notoSans(
                                              fontSize: 18),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            cartProvider.updateQuantity(
                                                cartItem.item.id,
                                                cartItem.quantity + 1);
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Color(0xff95C5D4),
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // 하단 버튼
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 24),
                      decoration: const BoxDecoration(
                        color: Color(0xFF95C5D4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: SafeArea(
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 18),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      '총 가격',
                                      style: GoogleFonts.notoSans(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      //${_formatPrice(item.price)}원
                                      '${_formatPrice(cartProvider.totalPrice)}원',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('구매 완료',
                                          style: GoogleFonts.notoSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: const Color(0xFF6B9DAD))),
                                      content: Text('구매가 성공적으로 완료되었습니다.',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 16,
                                          )),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Center(
                                            child: Text(
                                              '확인',
                                              style: GoogleFonts.notoSans(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                  cartProvider.clearCart();
                                },
                                child: Text(
                                  '구매하기',
                                  style: GoogleFonts.notoSans(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
