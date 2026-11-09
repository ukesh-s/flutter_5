import 'package:flutter/material.dart';

void main() => runApp(const BudgetApp());

class BudgetApp extends StatelessWidget {
  const BudgetApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, title: 'Personal Budget', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff5d4eb2)), useMaterial3: true), home: const BudgetPage());
}

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});
  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final _income = TextEditingController(), _expenses = TextEditingController();
  double? _balance;
  @override
  void dispose() { _income.dispose(); _expenses.dispose(); super.dispose(); }
  void _calculate() { final income = double.tryParse(_income.text), expenses = double.tryParse(_expenses.text); if (income == null || income < 0 || expenses == null || expenses < 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid non-negative amounts.'))); return; } setState(() => _balance = income - expenses); }
  @override
  Widget build(BuildContext context) { final positive = (_balance ?? 0) >= 0; return Scaffold(appBar: AppBar(title: const Text('Personal Budget')),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560), child: ListView(padding: const EdgeInsets.all(24), children: [const Text('Plan your month', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 8), const Text('Enter your monthly income and spending to see your financial status.'), const SizedBox(height: 24), TextField(controller: _income, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Monthly income', prefixText: '\$ ', border: OutlineInputBorder())), const SizedBox(height: 16), TextField(controller: _expenses, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Monthly expenses', prefixText: '\$ ', border: OutlineInputBorder())), const SizedBox(height: 18), FilledButton.icon(onPressed: _calculate, icon: const Icon(Icons.calculate), label: const Text('Calculate balance')), if (_balance != null) Card(color: positive ? Colors.green.shade50 : Colors.orange.shade50, margin: const EdgeInsets.only(top: 24), child: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(positive ? 'You are within budget' : 'You are over budget', style: TextStyle(color: positive ? Colors.green.shade800 : Colors.deepOrange.shade800, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text('Remaining balance: \$${_balance!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22))])))])))); }
}
