import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// 앱에서 정의한 커스텀 컬러셋
import '../styles/app_colors.dart';
// 상품 모델과 상태 관리
import '../models/item.dart';
import '../provider/item_provider.dart';
// 상품 상세 페이지
import 'item_detail.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // 상품 목록 갱신
    Future<void> _loadItems() async {
    await Provider.of<ItemProvider>(context, listen: false).loadItems();
  }

  // 초기 화면 진입 시 목록 로드
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _loadItems();
    });
  }
  /// 가격을 천 단위 콤마로 포맷해주는 함수
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }



  @override
  Widget build(BuildContext context) {
    // Provider를 통해 현재 상품 리스트 상태 가져오기
    final items = Provider.of<ItemProvider>(context).items;

    return Scaffold(
      // 상단 AppBar
      appBar: AppBar(
        title: Text(
          'Store',
          style: GoogleFonts.notoSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary, // 커스텀 컬러 사용
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/cart'); // 장바구니 페이지 이동
            },
            color: AppColors.primary,
          ),
        ],
        backgroundColor: AppColors.surface, // 커스텀 컬러 사용 
      ),

      // 본문 내용 (상품 리스트 or '상품 없음' 메시지)
      body: items.isEmpty
          ? Center(
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
              child: Column(
                children: [
                  // 로고 영역 (카드 형태로 표시)
                  Card(
                    color: AppColors.surface,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: GestureDetector(
                        // 로고 클릭 시 홈('/')으로 이동
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.asset(
                              'lib/assets/images/malang_banner.png', //로고 이미지
                              fit: BoxFit.contain,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 상품 리스트 (2열 그리드 카드)
                  Expanded(
                    child: GridView.builder(
                      itemCount: items.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,         // 2열로 배치
                        mainAxisSpacing: 12,       // 수직 간격
                        crossAxisSpacing: 12,      // 수평 간격
                        childAspectRatio: 1.0,     // 정사각형
                      ),
                      itemBuilder: (_, index) {
                        final item = items[index];

                        // 이미지 로딩 방식 분기 (assets 또는 File)
                        final imageWidget = item.imagePath.contains('lib/assets/')
                            ? Image.asset(
                                item.imagePath,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : Image.file(
                                File(item.imagePath),
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              );

                        return GestureDetector(
                          onTap: () {
                            // 상품 클릭 시 상세 페이지로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ItemDetail(item: item),
                              ),
                            );
                          },
                          child: Card(
                            color: AppColors.surface,
                            elevation: 5,
                            shadowColor: AppColors.cardShadow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 상품 이미지
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

                                // 상품 이름
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    item.name,
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: AppColors.onSurface,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                // 가격 표시
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    '${_formatPrice(item.price)}원',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
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
                  ),
                ],
              ),
            ),
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/register');
          _loadItems(); // 상품 등록 후 목록 갱신
        },
        child: Image.asset(
          'lib/assets/images/item_add.png', // 상품 등록 아이콘
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}

