import 'package:flutter/material.dart';
import 'package:flutter_application_1/toll_module/presentation/widgets/receipt_widget.dart';
import 'package:flutter_application_1/toll_module/presentation/widgets/toll_form_widget.dart';
class TollScreen extends StatefulWidget {
  const TollScreen({super.key});

  @override
  State<TollScreen> createState() => _TollScreenState();
}

class _TollScreenState extends State<TollScreen> {
  Map<String, double>? receiptStats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'TOLL TAX CALCULATION',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: TollFormwidget(
                callback: (receiptMap) {
                  setState(() {
                    receiptStats = receiptMap;
                  });
                },
              )),
              Flexible(
                  child: ReceiptWidget(
                receiptStats: receiptStats,
              ))
            ],
          ),
        ],
      ),
    );
  }
}
