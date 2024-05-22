import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:http/http.dart' as http;

class BarcodeScanService {
  Future<String?> scanBarcode() async {
    var result = await BarcodeScanner.scan();
    return result.rawContent;
  }

}
