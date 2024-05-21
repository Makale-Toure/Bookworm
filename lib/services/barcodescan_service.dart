import 'package:barcode_scan2/barcode_scan2.dart';

class BarcodeScanService {
  Future<String?> scanBarcode() async {
    var result = await BarcodeScanner.scan();
    return result.rawContent;
  }
}
