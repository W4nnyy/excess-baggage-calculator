import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weightController = TextEditingController();
  final rateController = TextEditingController(text: '15');


  String ticketClass = 'Economy';

  double excessWeight = 0;
  double excessCharge = 0;
  double totalAmount = 0;

  void calculate() {
    double? weight = double.tryParse(weightController.text);
    double? rate = double.tryParse(rateController.text);

    if (weight == null || rate == null || weight < 0 || rate < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
      return;
    }

    double allowance = ticketClass == 'Economy' ? 20 : 40;

    setState(() {
      excessWeight = weight - allowance;

      if (excessWeight < 0) {
        excessWeight = 0;
      }

      excessCharge = excessWeight * rate;
      totalAmount = excessCharge * 1.08;
    });
  }
  

    void reset() {
      setState(() {
        weightController.clear();
        rateController.text = '15';
        ticketClass = 'Economy';

        excessWeight = 0;
        excessCharge = 0;
        totalAmount = 0;
      });
    }

  @override
  void dispose() {
    weightController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excess Baggage Fee Calculator'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),


        drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.flight_takeoff,
              size: 60,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            const Text(
              'Excess Baggage Calculator',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Enter your baggage details to calculate the excess baggage fee.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            const Text('Baggage Weight (kg)'),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'Enter baggage weight',
              ),
            ),

            const SizedBox(height: 20),

            const Text('Ticket Class'),
            DropdownButton<String>(
              value: ticketClass,
              isExpanded: true,
              items: ['Economy', 'Business'].map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  ticketClass = value!;

                  if (ticketClass == 'Economy') {
                    rateController.text = '15';
                  } else {
                    rateController.text = '12';
                  }

                  excessWeight = 0;
                  excessCharge = 0;
                  totalAmount = 0;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text('Excess Rate per kg (RM)'),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: 'Enter rate per kg'),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: calculate,
              child: const Text('Calculate'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: reset,
              child: const Text('Reset'),
            ),


            const SizedBox(height: 30),

            const Text(
              'Calculation Result',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Excess Weight: ${excessWeight.toStringAsFixed(2)} kg',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Excess Charge: RM ${excessCharge.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Total Payable: RM ${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(
                'assets/images/my_photo.png',
              ),
            ),


              const SizedBox(height: 20),

              const Text(
                'Excess Baggage Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              const Text('Name: NUR SYAZWANI BINTI ZAINOR'),
              const SizedBox(height: 10),

              const Text('Matric No: 2024207102'),
              const SizedBox(height: 10),

              const Text('Course: M3CS2515A'),
              const SizedBox(height: 20),

              const Text('Copyright © 2026'),
              const SizedBox(height: 20),

              const Text('GitHub Repository:'),
              const SizedBox(height: 10),

              TextButton(
                onPressed: () async {
                  final url = Uri.parse(
                    'https://github.com/W4nnyy',
                  );
                  await launchUrl(url);
                },
                child: const Text('View GitHub Repository'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


