import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/currency_dropdown.dart';
import '../models/exchange_rate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String from = 'USD';
  String to = 'EUR';
  ExchangeRate? rate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRate();
  }

  Future<void> fetchRate() async {
    setState(() => isLoading = true);
    rate = await ApiService.getRate(from, to);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Exchange'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchRate,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrencyDropdown(
                  value: from,
                  onChanged: (val) => setState(() => from = val),
                ),
                const Icon(Icons.swap_horiz),
                CurrencyDropdown(
                  value: to,
                  onChanged: (val) => setState(() => to = val),
                ),
              ],
            ),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : rate != null
                    ? Column(
                        children: [
                          Text(
                            '1 $from = ${rate!.rate.toStringAsFixed(4)} $to',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text('Updated: ${rate!.date}')
                        ],
                      )
                    : const Text('No data'),
          ],
        ),
      ),
    );
  }
}
