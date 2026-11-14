import 'package:benim_uygulamam/components/product_card.dart';
import 'package:benim_uygulamam/models/products_model.dart';
import 'package:benim_uygulamam/services/api_service.dart';
import 'package:benim_uygulamam/views/card_screen.dart';
import 'package:benim_uygulamam/views/product_detail.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

// Uygulama renk paleti (tek yerden değiştirilebilir)
class AppColors {
  static const background = Color(0xFFF5F6FA);
  static const primary = Color(0xFF1F2A44);
  static const accent = Color(0xFF4F46E5);
  static const muted = Color(0xFF8A90A2);
  static const card = Colors.white;
}

enum ProductFilter { all, inCart, priceLow, priceHigh }

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({super.key});

  @override
  State<ProductHomeScreen> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHomeScreen> {
  ApiService apiService = ApiService();

  List<Data> allProducts = [];
  bool isLoading = false;
  String errorMessage = "";
  Set<int> cartIds = {};

  final TextEditingController searchController = TextEditingController();
  String searchText = "";
  ProductFilter selectedFilter = ProductFilter.all;

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final productModel = await apiService.fetchProducts();
      log("Ürünler getirildi");

      setState(() {
        allProducts = productModel.data!;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Hata oluştu: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // "$1,299.00" gibi metin fiyatı sayıya çevirir
  double _priceOf(Data p) {
    final cleaned = (p.price ?? '').toString().replaceAll(
      RegExp(r'[^0-9.]'),
      '',
    );
    return double.tryParse(cleaned) ?? 0;
  }

  // Arama + filtre uygulanmış liste
  List<Data> get visibleProducts {
    var list = allProducts.where((p) {
      final text = '${p.name ?? ''} ${p.tagline ?? ''}'.toLowerCase();
      return text.contains(searchText.toLowerCase());
    }).toList();

    switch (selectedFilter) {
      case ProductFilter.all:
        break;
      case ProductFilter.inCart:
        list = list.where((p) => cartIds.contains(p.id)).toList();
        break;
      case ProductFilter.priceLow:
        list.sort((a, b) => _priceOf(a).compareTo(_priceOf(b)));
        break;
      case ProductFilter.priceHigh:
        list.sort((a, b) => _priceOf(b).compareTo(_priceOf(a)));
        break;
    }
    return list;
  }

  // Günün önerisi: gün değiştikçe farklı ürün seçilir
  Data? get dailyPick {
    if (allProducts.isEmpty) return null;
    return allProducts[DateTime.now().day % allProducts.length];
  }

  void _openDetail(Data product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailScreen(findProduct: product, cardIds: cartIds),
      ),
    ).then((_) => setState(() {})); // geri dönünce sepet sayısı yenilensin
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CardScreen(allProducts: allProducts, cardIds: cartIds),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final products = visibleProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildBanner()),
            if (!isLoading && errorMessage.isEmpty && dailyPick != null)
              SliverToBoxAdapter(child: _buildDailyPick(dailyPick!)),
            SliverToBoxAdapter(child: _buildFilters()),
            if (isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (errorMessage.isNotEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text(errorMessage)),
              )
            else if (products.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    "Ürün bulunamadı",
                    style: TextStyle(color: AppColors.muted, fontSize: 16),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final findProduct = products[index];
                    return GestureDetector(
                      onTap: () => _openDetail(findProduct),
                      child: ProductCard(findProduct: findProduct),
                    );
                  }, childCount: products.length),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Discover',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: AppColors.primary,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Find your device',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
          // Sepet ikonu + ürün sayısı rozeti
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: IconButton(
                  onPressed: _openCart,
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (cartIds.isNotEmpty)
                Positioned(
                  right: 2,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartIds.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: searchController,
          onChanged: (value) => setState(() => searchText = value),
          decoration: InputDecoration(
            hintText: "Ürünleri Ara",
            hintStyle: const TextStyle(color: AppColors.muted),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: AppColors.accent),
            suffixIcon: searchText.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close, color: AppColors.muted),
                    onPressed: () {
                      searchController.clear();
                      setState(() => searchText = "");
                    },
                  ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          "https://wantapi.com/assets/banner.png",
          height: 90,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) =>
              Container(height: 90, color: AppColors.accent.withOpacity(0.1)),
        ),
      ),
    );
  }

  Widget _buildDailyPick(Data product) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GestureDetector(
        onTap: () => _openDetail(product),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '⭐ Günün Önerisi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.tagline ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${product.price ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  product.image ?? '',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    width: 90,
                    height: 90,
                    color: Colors.white24,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    const labels = {
      ProductFilter.all: 'Tümü',
      ProductFilter.priceLow: 'Fiyat: Artan',
      ProductFilter.priceHigh: 'Fiyat: Azalan',
      ProductFilter.inCart: 'Sepettekiler',
    };

    return SizedBox(
      height: 64,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        children: labels.entries.map((entry) {
          final selected = selectedFilter == entry.key;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: selected,
              showCheckmark: false,
              backgroundColor: AppColors.card,
              selectedColor: AppColors.primary,
              side: BorderSide.none,
              labelStyle: TextStyle(
                color: selected ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              onSelected: (_) => setState(() => selectedFilter = entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}
