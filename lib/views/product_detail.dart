import 'package:flutter/material.dart';
import 'package:benim_uygulamam/models/products_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Data findProduct;
  final Set<int> cardIds;

  const ProductDetailScreen({
    super.key,
    required this.findProduct,
    required this.cardIds,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.findProduct;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),

      appBar: AppBar(title: Text(product.name ?? "Detay")),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.image != null)
                  Image.network(
                    product.image!,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover, //kutuya tam yerleşsin
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                          height: 300,
                          child: Center(child: Icon(Icons.broken_image)),
                        ),
                  ),

                Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? '',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        widget.findProduct.description!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: Color.fromARGB(255, 20, 8, 8),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        product.tagline ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 18, 13, 13),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        widget.findProduct.price ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black12,
                          minimumSize: Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.cardIds.add(widget.findProduct.id!);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Kartı Ekle"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.amberAccent,
                              margin: EdgeInsets.only(
                                bottom: 80,
                                left: 40,
                                right: 20,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Satın Al",
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 193, 114, 114),
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
      ),
    );
  }
}
