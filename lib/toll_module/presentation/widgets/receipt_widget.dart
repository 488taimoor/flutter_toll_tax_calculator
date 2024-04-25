import 'package:flutter/material.dart';
class ReceiptWidget extends StatelessWidget {
   ReceiptWidget({super.key, this.receiptStats});
  Map<String, double>? receiptStats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Break down of Cost',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            const Divider(),

            RichText(
              text:  TextSpan(
                text: 'Base Rate : ',
                style: TextStyle(
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: receiptStats!=null? receiptStats!['base']!.toStringAsFixed(2):'',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' PKR'),
                ],
              ),
            ),
            RichText(
              text:  TextSpan(
                text: 'Distance : ',
                style: TextStyle(
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:receiptStats!=null? receiptStats!['distance']!.toStringAsFixed(2):'',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' km'),
                ],
              ),
            ),
            RichText(
              text:  TextSpan(
                text: 'Sub-Total : ',
                style: TextStyle(
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: receiptStats!=null? receiptStats!['subTotal']!.toStringAsFixed(2):'',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' PKR'),
                ],
              ),
            ),
            RichText(
              text:  TextSpan(
                text: 'Discount/Other : ',
                style: const TextStyle(
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: receiptStats!=null? receiptStats!['discount']!.toStringAsFixed(2):'',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' PKR'),
                ],
              ),
            ),
            Divider(),
            RichText(
              text:  TextSpan(
                text: 'TOTAL TO BE CHARGED : ',
                style: TextStyle(
                  fontSize: 24,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: receiptStats!=null? receiptStats!['total']!.toStringAsFixed(2):'',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' PKR'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
