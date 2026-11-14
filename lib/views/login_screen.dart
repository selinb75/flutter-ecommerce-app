import 'package:benim_uygulamam/views/home_screen.dart';
import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';

//import 'new_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LocalStorageService lsService = LocalStorageService();

  @override
  void dispose() {
    _usernameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 227, 223, 214),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey, //formKey → Form widget'ının durumunu yönetmek için kullanılan bir anahtar. Bu anahtar, formun doğrulama ve kaydetme işlemlerini kontrol etmek için kullanılır.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, //crossAxisAlignment: CrossAxisAlignment.stretch: Sütun içindeki elemanların (örneğin butonun) yatayda ekranı tamamen kaplamasını sağlar.
              children: [
                const Text(
                  "Giriş Ekranı",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 192, 31, 31),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      //kutunun etrafına tam bir dikdörtgen çerçeve çizebiliriz.
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 234, 225, 225),
                        width: 2.0,
                      ),
                    ),
                    //: Metin kutusunun içindeki, etrafındaki ve arka planındaki tüm görsel detayları (çerçeveler, etiketler, ikonlar, hata mesajları) InputDecoration ile ayarlarız.
                    //border → Metin kutusunun etrafındaki çerçeveyi belirler. OutlineInputBorder → Dış çerçeve şeklinde bir sınır oluşturur. borderRadius → Çerçevenin köşelerinin yuvarlatılmasını sağlar. Radius.circular(10.0) → 10.0 birimlik bir yarıçap ile köşeleri yuvarlatır.
                    hintText: "Kullanıcı Adı",
                    labelText: "Kullanıcı Adı",
                    prefixIcon: Icon(Icons.person),
                    //filled: true, //filled → true olursa arka plan rengi aktif olur. false olursa arka plan rengi aktif olmaz.
                    //fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      //trim() metodu, bir metin (string) içerisindeki en baştaki ve en sondaki gereksiz boşlukları (ve görünmeyen boşluk karakterlerini) silmek için
                      return "Bu alan boş bırakılamaz";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _surnameController,

                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      //kutunun etrafına tam bir dikdörtgen çerçeve çizebiliriz.
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 234, 225, 225),
                        width: 2.0,
                      ),
                    ),
                    hintText: "Soyad",
                    labelText: "Soyad",
                    prefixIcon: Icon(Icons.person),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      //trim() metodu, bir metin (string) içerisindeki en baştaki ve en sondaki gereksiz boşlukları (ve görünmeyen boşluk karakterlerini) silmek için
                      return "Bu alan boş bırakılamaz";
                    }
                    return null;
                  },
                ),
                //TextField içerisine yazılan kullanıcı adını alıp cihazın yerel hafızasına kaydetmek. içi save data
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      lsService.saveData(_usernameController.text); //lsService.saveData(_usernameController.text) → Kullanıcının girdiği kullanıcı adını cihazın yerel depolama alanına kaydeder. Bu, LocalStorageService sınıfındaki saveData metodunu çağırır ve kullanıcı adını kaydeder.
                      //formKey.currentState!.validate() → Form widget'ının geçerliliğini kontrol eder. Eğer tüm form alanları geçerliyse true, aksi halde false döner.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductHomeScreen(),
                        ),
                      );
                    }

                    // Giriş butonuna basıldığında yapılacak işlemler
                  },
                  child: Text("Giriş Yap"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
