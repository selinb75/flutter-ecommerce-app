import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

//SharedPreferences, uygulama içerisinde küçük verileri kalıcı olarak saklamamızı sağlayan bir Flutter paketidir.
class LocalStorageService {
  Future<void> saveData(String username) async {
    final prefs = await SharedPreferences.getInstance(); //SharedPreferences.getInstance() → SharedPreferences sınıfının bir örneğini almak için kullanılır. Bu örnek, cihazın yerel depolama alanına erişim sağlar ve verileri kaydetmek veya okumak için kullanılır.
    log('Kullanıcı adı kaydediliyor: $username');
    await prefs.setString('ls_name', username); //prefs.setString('username', username) → 'username' anahtarına karşılık gelen değeri kaydeder. Bu, kullanıcı adını cihazın yerel depolama alanına kaydetmek için kullanılır.
  }

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ls_name') ?? ''; //prefs.getString('username') → 'username' anahtarına karşılık gelen değeri okur. Eğer bu anahtar yoksa, varsayılan olarak boş bir string döndürür.
  } //?? '' → Eğer prefs.getString('username') null ise, yani 'username' anahtarı bulunamazsa, boş bir string döndürülür. Bu, null değerlerin önlenmesi için kullanılır.
  //?? nin sag kısmı calışır. yani null ise '' döndürür. null değilse prefs.getString('username') çalışır ve username döndürülür.
  //future kullanma sebebimiz gelecekte tamamlanacak bi işlemi temsil eder
  //Yani bir işlem hemen sonuçlanmıyorsa ve sonucunun daha sonra gelmesini bekliyorsak Future kullanırız.
  //ilgili ismi telefon hafızasına getiren get metodu ile çağırıyoruz. get metodu ile çağırdığımızda bize bir future döndürür. Future, gelecekte tamamlanacak bir işlemi temsil eder. Bu nedenle await kullanarak işlemin tamamlanmasını bekliyoruz.

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ls_name'); //prefs.remove('username') → 'username' anahtarına karşılık gelen değeri siler. Bu, kullanıcı adını cihazın yerel depolama alanından kaldırmak için kullanılır.
  }
}
