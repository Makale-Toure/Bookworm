import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:http/http.dart' as http;

class BarcodeScanService {
  Future<String?> scanBarcode() async {
    var result = await BarcodeScanner.scan();
    return result.rawContent;
  }

  Future<String> getBookInfo(String bookId) async {
    var url = Uri.parse('https://book-information-library.p.rapidapi.com/book/$bookId');
    var response = await http.get(url, headers: {
      'x-rapidapi-host': 'book-information-library.p.rapidapi.com',
      'x-rapidapi-key': 'f7d48ac5fcmsh5e5b6d2d51a5357p1f5316jsnb6bb4cd20783'
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load book info');
    }
  }
}
