class NewsModel {
  final int id;
  final String title;
  final String summary;
  final String image;
  final String category;
  final String author;
  final String content;
  NewsModel({
    required this.id,
    required this.title,
    required this.summary, //this.id: Gelen değeri sınıfın id değişkenine aktarır
    required this.image, //required: Bu parametrenin verilmesini zorunlu kılar.
    required this.category,
    required this.author,
    required this.content,
  });
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    //API'den gelen JSON verisini NewsModel nesnesine dönüştürür.
    return NewsModel(
      id: json['id'] ?? 0,
      title:
          json['title'] ?? '', //json içerisinde title varsa kullan null ise bos
      summary: json['summary'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      author: json['author'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
