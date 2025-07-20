import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ItemDetail extends StatefulWidget {
  final Item item;

  const ItemDetail({super.key, required this.item});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
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
    final screenWidth = MediaQuery.of(context).size.width;

    final formattedPrice = NumberFormat('#,###').format(widget.item.price);

    return Scaffold(
      backgroundColor: lightBlue, //seed color
      appBar: AppBar(
        title: Text(
          '상품 상세',
          style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 없이!
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.01,
            child: Container(
              decoration: BoxDecoration(
                color: blue,
              ),
            ),
          ),
          // 이미지 !!
          Container(
            color: Colors.white,
            width: double.infinity,
            height: screenHeight * 0.35,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/background.png',
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  widget.item.imagePath,
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

// 상품명, 가격 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${formattedPrice}원',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: black3),
                ),
              ],
            ),
          ),
          // 설명 영역
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 6), // 없어도 될듯?
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '상품 정보',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),

                        /// 흰 박스의 기본 높이를 넉넉하게 확보해두되,
                        /// 내용이 넘치면 박스 내부에서 스크롤 가능하게!
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.245, // 흰색 박스 기본 높이
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.item.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 하단의 네비게이션 바!!!!
      // --> 그림자 추가하고 박스 좌우 패딩주기
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom + 3),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.015,
          ),
          height: screenHeight * 0.09,
          margin: EdgeInsets.symmetric(
              horizontal:
                  screenWidth * 0.03), // width: double.infinity 대신!! 양옆 띄워두기
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(30),
            color: blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),

          // width: double.infinity,
          // alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 수량 조절 (--> 고정 width)
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.3,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          _quantityBox(
                            onPressed: _decreaseQuantity,
                            icon: Icons.remove,
                          ),
                          const SizedBox(width: 2),
                          // -->좌우 박스보다 1.5배 크기 (contailner써서 숫자 늘어날때 크기 조절되게)
                          Container(
                            width: screenWidth * 0.1,
                            height: screenHeight * 0.045,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // alignment: Alignment.center,
                            child: Center(
                              child: Text('$quantity',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 2),
                          _quantityBox(
                            onPressed: _increaseQuantity,
                            icon: Icons.add,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(width: screenWidth * 0.03),

                // // 총 가격 텍스트 및 금액 (겹치게 배치) !!!

                // SizedBox(
                //   width: screenWidth * 0.3, // 총 가격 영역 너비 조절
                //   height: screenHeight * 0.1, // Stack 높이 조절
                //   child: Stack(
                //     children: [
                //       // '총 가격' 텍스트 (위쪽)
                //       Positioned(
                //         left: 0,
                //         top: screenHeight * 0.005,
                //         child: Text(
                //           '총 가격',
                //           style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //       // 가격 텍스트 (조금 아래, 겹쳐지게)
                //       Positioned(
                //         left: screenWidth * 0.1,
                //         top: screenHeight * 0.03, // 이 값을 조정하면 겹침 정도 조절 가능
                //         child: Text(
                //           '${widget.item.price * quantity}원',
                //           style: const TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                //  총 가격 텍스트 및 금액 (가로로 배치) !! (--> flexible하게)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Center(
                    child: Text(
                      '총 ${NumberFormat('#,###').format(widget.item.price * quantity)}원',
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                ///
                SizedBox(width: screenWidth * 0.01),

                /// 장바구니 버튼 추가할까??!!!
                /// final cartProvider = Provider.of<CartProvider>(context, listen: false);

                /// ElevatedButton(
                ///   onPressed: () {
                /// cartProvider.addItem(widget.item.copyWith(quantity: 1));
                ///     ScaffoldMessenger.of(context).showSnackBar(
                ///       const SnackBar(content: Text('장바구니에 담겼습니다!')),
                ///     );
                ///   },
                ///   child: const Text('장바구니 담기'),
                /// ),

                /// 구매 버튼!!
                ElevatedButton(
                  onPressed: _showPurchaseDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // fixedSize: const Size(100, 50),
                    minimumSize: const Size(100, 55),
                  ),
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    child: Text(
                      '구매하기',
                      style: TextStyle(
                          fontSize: 20,
                          color: black3,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 수량 조절 관련 위젯!!!
  ///

  void _increaseQuantity() {
    if (quantity < 99) {
      setState(() {
        quantity++;
      });
    }
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _showPurchaseDialog() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('구매 확인'),
        content: Text('${widget.item.name}!! $quantity개 구매하시겠어요?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소', style: TextStyle(color: Colors.blueGrey)),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            child: const Text('확인',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
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
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (Navigator.canPop(ctx)) {
            Navigator.pop(ctx);
          }
        });
        return const CupertinoAlertDialog(
          title: Text('🐙 구매 완료 🐙',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text('감사합니다!',
              style: TextStyle(fontSize: 16, color: Colors.black54)),
        );
      },
    );
  }

  Widget _quantityBox(
      {IconData? icon, VoidCallback? onPressed, Widget? child}) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenHeight * 0.03,
      height: screenHeight * 0.045,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: icon != null
            ? IconButton(
                icon: Icon(icon, size: 24, color: black3),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onPressed,
              )
            : child!,
      ),
    );
  }
}
