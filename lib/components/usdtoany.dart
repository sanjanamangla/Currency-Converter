import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdToAny({super.key, required this.rates, required this.currencies});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {

  TextEditingController usdController = TextEditingController();
  String dropDownValue= 'AUD';
  String answer= '';
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('USD to Any Currency',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            SizedBox(height: 20,),
            TextFormField(
              key: ValueKey('usd'),
              controller: usdController,
              decoration: InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: dropDownValue,
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String? newValue){
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                    .toSet()
                    .toList()
                    .map<DropdownMenuItem<String>>((value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                  ),
                  SizedBox(width: 10,),
                  Container(
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          answer = usdController.text+
                          'USD = ' +
                          convertTousd(widget.rates, usdController.text,dropDownValue)+
                          ' '+
                          dropDownValue;
                        });
                      }, 
                      child: Text('Convert'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor
                        )
                      ),),
                  ),
                  SizedBox(width: 10,)
              ],
            ),
            SizedBox(height: 10,),
            Container(child: Text(answer),)
          ],
        ),
      ),
    );
  }
}


String convertTousd(Map exchangeRates, String usd, String currency) {
  // Ensure 'usd' is a valid number and convert it to double
  double usdAmount = double.tryParse(usd) ?? 0.0; 

  // Get the exchange rate for the selected currency
  double exchangeRate = exchangeRates[currency] ?? 1.0; 

  // Calculate the converted amount
  double convertedAmount = usdAmount * exchangeRate;

  // Format the result to 2 decimal places
  String output = convertedAmount.toStringAsFixed(2);

  return output;
}
