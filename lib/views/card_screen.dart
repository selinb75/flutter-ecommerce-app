import 'package:flutter/material.dart';
import 'package:benim_uygulamam/models/products_model.dart';
import 'package:benim_uygulamam/components/mini_card_tile.dart';

class CardScreen extends StatefulWidget {
  final List<Data> allProducts;
  final Set<int> cardIds;

  const CardScreen({
    super.key,
    required this.allProducts,
    required this.cardIds,
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  static const _background = Color(0xFFF5F6FA);
  static const _primary = Color(0xFF1F2A44);
  static const _accent = Color(0xFF4F46E5);
  static const _currency = '\$'; // para birimini buradan değiştirebilirsin

  double _priceOf(Data p) {
    final cleaned = (p.price ?? '').toString().replaceAll(
      RegExp(r'[^0-9.]'),
      '',
    );
    return double.tryParse(cleaned) ?? 0;
  }

  List<Data> get _cartProducts => widget.allProducts
      .where((element) => widget.cardIds.contains(element.id))
      .toList();

  double get _total =>
      _cartProducts.fold(0.0, (sum, item) => sum + _priceOf(item));

  // Ödeme onay penceresi
  Future<void> _checkout() async {
    final total = _total;
    final count = _cartProducts.length;

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Siparişi Onayla',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _primary,
              ),
            ),
            const SizedBox(height: 16),
            _summaryRow('Ürün sayısı', '$count'),
            const SizedBox(height: 8),
            _summaryRow(
              'Toplam',
              '$_currency${total.toStringAsFixed(2)}',
              bold: true,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Vazgeç'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Onayla'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => widget.cardIds.clear());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Siparişin alındı 🎉')));
    }
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: bold ? _primary : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 20 : 16,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
            color: _primary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = _cartProducts;

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.w700, color: _primary),
        ),
        backgroundColor: _background,
        elevation: 0,
        iconTheme: const IconThemeData(color: _primary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Your cart is empty!!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Text(
                              "Add items to start shopping!!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final item = cartProducts[index];
                          return MiniCardTile(
                            name: item.name ?? '',
                            tagline: item.tagline ?? '',
                            price: item.price ?? '',
                            imageUrl: item.image ?? '',
                            onRemove: () {
                              setState(() {
                                widget.cardIds.remove(item.id);
                              });
                            },
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              if (cartProducts.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _summaryRow(
                        'Ürünler (${cartProducts.length})',
                        '$_currency${_total.toStringAsFixed(2)}',
                      ),
                      const Divider(height: 24),
                      _summaryRow(
                        'Toplam',
                        '$_currency${_total.toStringAsFixed(2)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: cartProducts.isEmpty ? null : _checkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  disabledBackgroundColor: Colors.black12,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
