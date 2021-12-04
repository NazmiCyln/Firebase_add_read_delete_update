// ignore_for_file: unused_import, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  //Program çalışır çalışmaz firebase'i başlat
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseCrud(),
  ));
}

class FirebaseCrud extends StatefulWidget {
  const FirebaseCrud({Key? key}) : super(key: key);

  @override
  _FirebaseCrudState createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  //**********************
  late String ad, id, kategori;
  late int sayfa;

  //Alınan verileri değişkenlere aktar
  idAl(idTutucu) {
    id = idTutucu;
  }

  adAl(adTutucu) {
    ad = adTutucu;
  }

  kategoriAl(kategoriTutucu) {
    kategori = kategoriTutucu;
  }

  sayfaAl(sayfaTutucu) {
    sayfa = int.parse(sayfaTutucu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter işlemleri"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextFormField(
              //Alınan verileri idTutucuda tutuyoruz
              //idTutucusundaki veriyi idAl methoduna aktardım
              onChanged: (String idTutucu) {
                idAl(idTutucu);
              },
              decoration: const InputDecoration(
                labelText: "Id",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff454545), width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextFormField(
              //Alınan verileri adTutucuda tutuyoruz
              //adTutucusundaki veriyi adAl methoduna aktardım
              onChanged: (String adTutucu) {
                adAl(adTutucu);
              },
              decoration: const InputDecoration(
                labelText: "Ad",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff454545), width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextFormField(
              //Alınan verileri kategoriTutucuda tutuyoruz
              //kategoriTutucusundaki veriyi kategoriAl methoduna aktardım
              onChanged: (String kategoriTutucu) {
                kategoriAl(kategoriTutucu);
              },
              decoration: const InputDecoration(
                labelText: "Kategori",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff454545), width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextFormField(
              //Alınan verileri sayfaTutucuda tutuyoruz
              //sayfaTutucusundaki veriyi sayfaAl methoduna aktardım
              onChanged: (String sayfaTutucu) {
                sayfaAl(sayfaTutucu);
              },
              decoration: const InputDecoration(
                labelText: "Sayfa",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff454545), width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              //satırda dağıtma işlemi
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    veriEkle();
                  },
                  child: const Text("Ekle"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF0A8922),
                    onPrimary: Colors.white,
                    //Gölge rengi ve gölge boyutu
                    shadowColor: Colors.redAccent,
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriOku();
                  },
                  child: const Text("Oku"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFA3AA06),
                    onPrimary: Colors.white,
                    //Gölge rengi ve gölge boyutu
                    shadowColor: Colors.redAccent,
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriGuncelle();
                  },
                  child: const Text("Güncelle"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF0343BF),
                    onPrimary: Colors.white,
                    //Gölge rengi ve gölge boyutu
                    shadowColor: Colors.redAccent,
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriSil();
                  },
                  child: const Text("Sil"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF9E0202),
                    onPrimary: Colors.white,
                    //Gölge rengi ve gölge boyutu
                    shadowColor: Colors.redAccent,
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("Kitaplık").snapshots(),
            builder: (context, alinanVeri) {
              if (alinanVeri.hasError) {
                return const Text("Aktarım başarısız.");
              }
              var veriler = alinanVeri.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: veriler.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot satirVerisi = veriler[index];

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            satirVerisi["kitapId"],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            satirVerisi["kitapAd"],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            satirVerisi["kitapKategori"],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            satirVerisi["kitapSayfa"].toString(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  //*********Firebase veri gönderilmesi
  void veriEkle() {
    //Veri yolu ekleme
    //İlk önce veri yolu oluşturuluyor
    DocumentReference veriYolu =
        FirebaseFirestore.instance.collection("Kitaplık").doc(id);

    //Çoklu veri için Map kullanılıyor
    Map<String, dynamic> kitaplar = {
      "kitapId": id,
      "kitapAd": ad,
      "kitapKategori": kategori,
      "kitapSayfa": sayfa.toString(),
    };

    //Veriyi veri tabanına ekle
    veriYolu.set(kitaplar).whenComplete(() {
      Fluttertoast.showToast(msg: id + " Id'li kitap eklendi");
    });
  }

  //*********Verileri okuyacak
  void veriOku() {
    //Veri yolu
    DocumentReference veriOkumaYolu =
        FirebaseFirestore.instance.collection("Kitaplık").doc(id);

    //Veriyi al "alinanDeger'e " aktar
    veriOkumaYolu.get().then((alinanDeger) {
      //Çoklu veriyi map'e aktar
      //"alinanDeger"deki verileri "alinanVeri" olarak aktar
      Map<String, dynamic> alinanVeri =
          alinanDeger.data() as Map<String, dynamic>;

      //"alinanVeri" deki alanları tutuculara aktar
      String idTutucu = alinanVeri["kitapId"];
      String adTutucu = alinanVeri["kitapAd"];
      String kategoriTutucu = alinanVeri["kitapKategori"];
      String sayfaTutucu = alinanVeri["kitapSayfa"];

      Fluttertoast.showToast(
          msg: "Id: " +
              idTutucu +
              " Ad: " +
              adTutucu +
              " Kategori: " +
              kategoriTutucu +
              " Sayfa Sayısı: " +
              sayfaTutucu);
    });
  }

  //*********Verilerin güncellenmesi
  void veriGuncelle() {
    //Veriyolu
    DocumentReference veriGuncellemeYolu =
        FirebaseFirestore.instance.collection("Kitaplık").doc(id);

    //çoklu veri mapi
    Map<String, dynamic> guncellenecekVeri = {
      "kitapId": id,
      "kitapAd": ad,
      "kitapKategori": kategori,
      "kitapSayfa": sayfa,
    };

    //Veriyi güncelle
    veriGuncellemeYolu.update(guncellenecekVeri).whenComplete(() {
      Fluttertoast.showToast(msg: id + " Id'li kitap güncellendi.");
    });
  }

  //*********Verilerin silinmesi
  void veriSil() {
    //Veriyolu
    DocumentReference veriSilmeYolu =
        FirebaseFirestore.instance.collection("Kitaplık").doc(id);

    //Veriyi sildirme
    veriSilmeYolu.delete().whenComplete(() {
      Fluttertoast.showToast(msg: id + " Id'li kitap silindi.");
    });
  }
}
