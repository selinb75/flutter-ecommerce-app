# Mini Katalog Uygulaması

Flutter ile geliştirilmiş basit bir ürün katalog uygulaması. Ürünler API'den çekilir, ana sayfada kart tabanlı bir listede gösterilir. Kullanıcı ürün detayına bakabilir, sepete ekleyebilir ve ödeme adımına geçebilir.

## Özellikler

- Giriş, ana sayfa, ürün detayı ve sepet ekranları (Navigator ile sayfa geçişleri)
- API'den ürün listesini çekme (yükleniyor ve hata durumları)
- GridView ile kart tabanlı ürün listesi
- Ürün arama
- Filtreleme: fiyata göre artan/azalan sıralama ve sepettekiler
- Günün önerisi kartı
- Sepete ekleme/çıkarma, sepet rozeti ve toplam tutar
- Checkout onay ekranı

## Kullanılan Flutter Sürümü

```
Flutter 3.47.9 (stable)
Dart 3.13.7
DevTools 2.60.0
```

## Proje Yapısı

```
lib/
├── components/   # Tekrar kullanılan widget'lar (product_card, mini_card_tile)
├── models/       # Veri modelleri (products_model)
├── services/     # API ve yerel depolama servisleri
├── views/        # Ekranlar (login, home, product_detail, card_screen)
└── main.dart
```

## Çalıştırma Adımları

1. Flutter'ın kurulu olduğundan emin olun:
   ```
   flutter --version
   ```
2. Repoyu klonlayın:
   ```
   git clone https://github.com/KULLANICI_ADI/REPO_ADI.git
   cd REPO_ADI
   ```
3. Bağımlılıkları yükleyin:
   ```
   flutter pub get
   ```
4. Bir emülatör başlatın ya da cihaz bağlayın, ardından uygulamayı çalıştırın:
   ```
   flutter run
   ```

> Ürün verileri internetten çekildiği için uygulamanın çalışması için internet bağlantısı gerekir.

## Ekran Görüntüleri

| Giriş | Ana Sayfa |
|-------|-----------|
| ![Giriş](<img width="1344" height="2992" alt="Screenshot_1794685406" src="https://github.com/user-attachments/assets/c2dcb9a2-7e63-436c-ba5b-1ad499e21fa3" /><img width="1344" height="2992" alt="Screenshot_1794685420" src="https://github.com/user-attachments/assets/71f99f0f-223a-4a00-b292-37dc20ecc50f" />
) | ![Ana Sayfa] |

| Ürün Detayı | Sepet |
|-------------|-------|
| ![Detay]<img width="1344" height="2992" alt="Screenshot_1794685462" src="https://github.com/user-attachments/assets/91d77ad8-768a-46f2-bc11-adb0ff813da4" />
 | ![Sepet]<img width="1344" height="2992" alt="Screenshot_1794685471" src="https://github.com/user-attachments/assets/a0c436a0-afb5-4430-8c00-abb0ce0d9963" />
 |
