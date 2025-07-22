import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// 상품 모델과 상태 관리
import '../provider/item_provider.dart';
// 앱에서 정의한 커스텀 컬러셋
import '../styles/app_colors.dart';
// 상품 상세 페이지
import 'item_detail2.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // 상품 목록 갱신
  Future<void> _loadItems() async {
    await Provider.of<ItemProvider>(context, listen: false)
        .loadItems(); // 상태 업데이트
  }

  //초기 화면 진입 시 목록 로드
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _loadItems();
    });
  }

  // 가격을 3자리마다 쉼표로 구분하는 함수
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemProvider>(context).items; // 아이템 목록 가져오기

    return Scaffold(
      // 스캐폴드 위젯으로 기본 레이아웃 구성
      // 상단 AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Store',
          style: GoogleFonts.notoSans(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            // 장바구니 아이콘 버튼
            icon: const Icon(Icons.shopping_cart_outlined),
            iconSize: 30,
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            color: AppColors.primary,
          ),
        ],
        backgroundColor: AppColors.surface,
      ),
      // 본문 내용 (상품 리스트 or '상품 없음' 메시지)
      body: items.isEmpty
          ? Center(
              // 상품이 없을 때 표시할 위젯
              child: Text(
                '상품이 없습니다.',
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  // 스크롤 가능한 로고 영역
                  Card(
                    color: AppColors.surface,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: GestureDetector(
                        // 로고 클릭 시 타임세일 전단으로 이동
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/time_sale');
                        },
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'lib/assets/images/sale_banner.png',
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 상품 그리드

                  GridView.builder(
                    // 그리드 뷰로 상품 목록 표시
                    shrinkWrap: true, // 부모 위젯의 크기에 맞게 조정
                    physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2열로 배치
                      mainAxisSpacing: 12, // 수직 간격
                      crossAxisSpacing: 12, // 수평 간격
                      childAspectRatio: 1.0, // 정사각형
                    ),
                    itemBuilder: (_, index) {
                      final item = items[index];
                      // 이미지 로딩 방식 분기 (assets 또는 File)

                      final imageWidget =
                          item.imagePath.contains('lib/assets/') // 로컬 이미지 경로 확인
                              ? Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Image.file(
                                  // 파일 경로 확인
                                  File(item.imagePath),
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                );

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ItemDetail2(item: item), // 아이템 상세 페이지로 이동
                            ),
                          );
                        },
                        child: Card(
                          // 상품 카드
                          color: AppColors.surface,
                          elevation: 5,
                          shadowColor: AppColors.cardShadow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: imageWidget,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  item.name,
                                  style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: AppColors.onSurface,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  item.price == 0
                                      ? '무료'
                                      : '${_formatPrice(item.price)}원', // 가격 표시

                                  style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColors.onSurface,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // 터치 시 물결 효과 제거
          highlightColor: Colors.transparent, // 터치 시 하이라이트 효과 제거
          shadowColor: Colors.transparent, // 그림자 제거
        ),
        child: FloatingActionButton.large(
          // 상품 등록 버튼 .large 사용
          backgroundColor: Colors.transparent, // 투명 배경
          elevation: 0, // 그림자 제거
          onPressed: () async {
            await Navigator.pushNamed(context, '/register'); // 상품 등록 페이지로 이동
            _loadItems(); // 상품 목록 갱신
          },
          child: Image.asset(
            'lib/assets/images/item_add.png', // 상품 등록 아이콘
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
