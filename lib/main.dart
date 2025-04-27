/*
•	Üniversite : Erciyes Üniversitesi
•	Fakülte : Mühendislik Fakültesi
•	İsim ve Soyisim: Muhammet Dülek
•	Numara: 1030521020
•	Bölüm : Bilgisayar Mühendisliği
•	Ders : Mobile Application Development
•	Öğretim Üyesi: Dr. Fehim Köylü
•	Proje Ödevi : Stateful Dropdown ve Liste Etkileşimi
*/


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown ve Liste Etkileşimi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductFilterPage(),
    );
  }
}

class ProductFilterPage extends StatefulWidget {
  @override
  _ProductFilterPageState createState() => _ProductFilterPageState();
}

class _ProductFilterPageState extends State<ProductFilterPage> {
  // Kategoriler
  final List<String> categories = ['Tümü', 'Elektronik', 'Giyim', 'Kitaplar', 'Mobilya'];
  String selectedCategory = 'Tümü';

  // Ürünler ve kategorileri
  final Map<String, List<Product>> productsByCategory = {
    'Tümü': [],
    'Elektronik': [],
    'Giyim': [],
    'Kitaplar': [],
    'Mobilya': []
  };

  List<Product> displayedProducts = [];

  @override
  void initState() {
    super.initState();

    // Örnek ürünler eklenir
    productsByCategory['Elektronik']!.addAll([
      Product('Laptop', 'Yüksek performanslı laptop', 9999.99),
      Product('Akıllı Telefon', 'Son model akıllı telefon', 7999.99),
      Product('Tablet', 'İnce ve hafif tablet', 4999.99),
    ]);

    productsByCategory['Giyim']!.addAll([
      Product('T-Shirt', 'Pamuklu t-shirt', 199.99),
      Product('Jean', 'Slim fit jean', 399.99),
      Product('Ceket', 'Su geçirmez ceket', 899.99),
    ]);

    productsByCategory['Kitaplar']!.addAll([
      Product('Roman', 'Çok satan roman', 49.99),
      Product('Bilim', 'Bilim kitabı', 69.99),
      Product('Tarih', 'Tarih ansiklopedisi', 129.99),
    ]);

    productsByCategory['Mobilya']!.addAll([
      Product('Koltuk', 'Konforlu koltuk takımı', 5999.99),
      Product('Masa', 'Yemek masası', 2999.99),
      Product('Dolap', 'Geniş gardırop', 3999.99),
    ]);

    // Tüm ürünleri ekle
    for (var category in categories.where((c) => c != 'Tümü')) {
      productsByCategory['Tümü']!.addAll(productsByCategory[category]!);
    }

    // Başlangıçta tüm ürünleri göster
    displayedProducts = List.from(productsByCategory['Tümü']!);
  }

  void updateProductList(String category) {
    setState(() {
      selectedCategory = category;
      displayedProducts = List.from(productsByCategory[category]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Filtreleme'),
      ),
      body: Column(
        children: [
          // Dropdown bileşeni
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('Kategori: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedCategory,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      updateProductList(newValue);
                    }
                  },
                  items: categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Liste bileşeni
          Expanded(
            child: ListView.builder(
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                final product = displayedProducts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: Text(
                      '${product.price.toStringAsFixed(2)} TL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      // Ürüne tıklama işlemi burada yapılabilir
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} seçildi')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;

  Product(this.name, this.description, this.price);
}


class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // Durum değişkenleri burada tanımlanır

  @override
  Widget build(BuildContext context) {
    // UI bileşenleri burada oluşturulur
    return Container();
  }
}