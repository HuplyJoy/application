import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String? scannedData;
  bool isScanned = false;

  final MobileScannerController cameraController = MobileScannerController();

  void _onDetect(BarcodeCapture capture) {
    if (isScanned) return;

    final barcode = capture.barcodes.firstOrNull;
    final String? value = barcode?.rawValue;

    if (value != null) {
      setState(() {
        scannedData = value;
        isScanned = true;
      });
      cameraController.stop();

      // Wait 3 seconds, then go back
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pop(context, scannedData); // I can return the result too
        }
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
            tooltip: 'Toggle Flashlight',
          ),
        ],
      ),
      body: Center(
        child:
            !isScanned
                ? Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            MobileScanner(
                              controller: cameraController,
                              onDetect: _onDetect,
                            ),
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.black87,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(16),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'وجه الكود داخل الإطار',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.symmetric(
                                        horizontal: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary.withAlpha(170),
                                          width: 6,
                                        ),
                                      ),
                                    ),
                                    child: MobileScanner(
                                      fit: BoxFit.cover,
                                      controller: cameraController,
                                      onDetect: _onDetect,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'تم المسح بنجاح',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Icon(
                      Icons.check_circle,
                      size: 110,
                      color: Colors.green,
                    ),
                  ],
                ),
      ),
    );
  }
}
