import 'package:flutter/material.dart';
import 'package:gel_converter/logic/currency_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _enteredAmount = 0;
  String? _toCurrency;
  double _convertedAmount = 0;
  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  final List<String> _currencies = [
    'USD',
    'GBP',
    'EUR',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Listener(
      onPointerDown: (_) => _focusNode.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _focusNode.unfocus();
                  _textEditingController.clear();
                  _enteredAmount = 0;
                  _toCurrency = null;
                  _convertedAmount = 0;
                });
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Text(
            'GEL Converter',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: deviceSize.height / 1.3,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue,
                  Colors.purple,
                ]),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'GEL:',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      SizedBox(
                        height: 60,
                        width: 100,
                        child: Center(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _textEditingController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            onChanged: (text) {
                              setState(() {
                                var amount = double.tryParse(text);
                                if (amount != null) {
                                  _enteredAmount = amount;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'To:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        width: 100,
                        height: 60,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            selectedItemBuilder: (_) => _currencies
                                .map((e) => Center(child: Text(e)))
                                .toList(),
                            iconEnabledColor: Colors.white,
                            value: _toCurrency,
                            borderRadius: BorderRadius.circular(35),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            items: _currencies
                                .map(
                                  (currency) => DropdownMenuItem<String>(
                                    value: currency,
                                    child: Text(
                                      currency,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                _toCurrency = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Converted amount is \n$_convertedAmount",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                        ),
                      ),
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          if (_toCurrency == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please choose the currency!'),
                              ),
                            );
                          } else {
                            setState(() {
                              _convertedAmount = CurrencyHelper()
                                  .convertTo(_enteredAmount, _toCurrency);
                            });
                          }
                        },
                        icon: const Icon(Icons.change_circle),
                        label: const Text(
                          'Convert',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
