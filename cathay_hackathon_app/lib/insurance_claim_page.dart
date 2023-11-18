import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'member.dart';

class InsuranceClaimPage extends StatefulWidget {
  InsuranceClaimPage({super.key, required this.passenger});
  Passenger passenger;

  @override
  State<InsuranceClaimPage> createState() => _InsuranceClaimPageState();
}

class _InsuranceClaimPageState extends State<InsuranceClaimPage> {
  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromRGBO(191, 179, 157, 1);
    Passenger psg = widget.passenger;
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column (
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Personal Belongings", style: TextStyle(fontSize: 18)),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Example ---\nStolen: Mobile phone'
                      ),
                    )
                  ]
                )
              )
            ),
            const SizedBox(height: 16),
            const Card(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        children: [
                          Text("Luggage", style: TextStyle(fontSize: 18)),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Example ---\nBroken: Suitcase'
                            ),
                          )
                        ]
                    )
                )
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('Generate Email', style: TextStyle(fontSize: 16)),
              onPressed: () {
                launchUrl(Uri(
                  scheme: 'mailto',
                  path: 'claim@safeguard.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Claim for Suitcase Damage during Cathay Pacific Flight on 19/11/2023',
                    'body': """Dear Safeguard Company,
I hope this email finds you well. I am writing to file a claim for damages to my suitcase that occurred during a recent flight with Cathay Pacific on 19/11/2023.
On the mentioned date, I traveled from Hong Kong to Osaka on Cathay Pacific Flight CX566. Upon arrival at my destination, I discovered that my suitcase had been noticeably damaged. The damage includes a broken handle, a cracked corner, and significant scratches on the surface.
To support my claim, I have attached photographs of the damaged suitcase for your reference. Additionally, I have enclosed the boarding pass and baggage claim receipts as evidence of the flight details and ownership of the suitcase.
I would like to request reimbursement for the repair or replacement costs of the damaged suitcase as per the terms and conditions of the insurance policy. The policy number associated with this claim is [Policy Number], and the coverage period is valid at the time of the incident.
I kindly request your prompt attention to this matter and a swift resolution of my claim. If there are any additional documents or information required to process my claim, please let me know at your earliest convenience. I am available via email at [Your Email Address] or by phone at [Your Contact Number] should you need to reach me.
I look forward to a positive resolution to this claim and appreciate your assistance in this matter. Thank you for your attention and prompt action.
Yours sincerely,
[Your Name]"""
                  })
                ));
              },
            )
          ]
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}