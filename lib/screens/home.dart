import 'package:currency_converter/components/anytoany.dart';
import 'package:currency_converter/components/usdtoany.dart';
import 'package:currency_converter/functions/fetchcurrencies.dart';
import 'package:currency_converter/functions/fetchrates.dart';
import 'package:currency_converter/models/ratesmodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    result = fetchrates();
    allcurrencies = fetchcurrencies();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Open Exchange')),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/currency.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching rates: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.rates.isEmpty) {
                  return Center(child: Text('No rate data available.'));
                }
                return FutureBuilder<Map>(
                  future: allcurrencies,
                  builder: (context, currSnapshot) {
                    if (currSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (currSnapshot.hasError) {
                      return Center(child: Text('Error fetching currencies: ${currSnapshot.error}'));
                    } else if (!currSnapshot.hasData || currSnapshot.data!.isEmpty) {
                      return Center(child: Text('No currency data available.'));
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UsdToAny(
                          currencies: currSnapshot.data!,
                          rates: snapshot.data!.rates,
                        ),
                        AnyToAny(
                          currencies: currSnapshot.data!,
                          rates: snapshot.data!.rates,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
