import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalimat Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KalimatConverter(),
    );
  }
}

class KalimatConverter extends StatefulWidget {
  @override
  _KalimatConverterState createState() => _KalimatConverterState();
}

class _KalimatConverterState extends State<KalimatConverter> {
  TextEditingController _controller = TextEditingController();
  String _hasil = '';

  void _convertKalimat(String kalimat) {
    kalimat = kalimat.replaceAll(' ', '');

    Map<String, int> kemunculanHuruf = {};
    Map<String, int> indexPertama = {};

    for (int i = 0; i < kalimat.length; i++) {
      String karakter = kalimat[i];
      if (kemunculanHuruf.containsKey(karakter)) {
        kemunculanHuruf[karakter] = kemunculanHuruf[karakter]! + 1;
      } else {
        kemunculanHuruf[karakter] = 1;
        indexPertama[karakter] = i;
      }
    }

    if (kemunculanHuruf.containsKey('O')) {
      kemunculanHuruf['O'] = kemunculanHuruf['O']! - 1;
    }

    List<String> listHuruf = kemunculanHuruf.keys.toList();

    listHuruf.sort((a, b) {
      if (kemunculanHuruf[a] != kemunculanHuruf[b]) {
        return kemunculanHuruf[b]!.compareTo(kemunculanHuruf[a]!);
      }
      return indexPertama[a]!.compareTo(indexPertama[b]!);
    });

    String hasil = '';
    for (String karakter in listHuruf) {
      if (kemunculanHuruf[karakter]! > 1) {
        hasil += karakter + kemunculanHuruf[karakter].toString();
      } else {
        hasil += karakter;
      }
    }

    setState(() {
      _hasil = hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalimat Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Masukkan Kalimat',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String inputKalimat = _controller.text;
                _convertKalimat(inputKalimat);
              },
              child: Text('Konversi'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hasil Konversi:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_hasil),
          ],
        ),
      ),
    );
  }
}
