import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter_upi/flutter_upi.dart';

final CreditCard testCard = CreditCard(
  number: '4000002760003184',
  expMonth: 12,
  expYear: 21,
);
Future _initiateTransaction;

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  Source _source;
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_IduIePILfTe6zAFJ68e2irWJ00a2orCA33",
        merchantId: "Test",
        androidPayMode: 'test'));
    // createsource();
  }

  _cardpayment() {
    StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
        .then((paymentMethod) {
      Fluttertoast.showToast(msg: 'Received');
      print(paymentMethod.id);
      //  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received ${paymentMethod.id}')));
      setState(() {
        _paymentMethod = paymentMethod;
      });
    }).catchError((error) {
      print(error);
    });
  }

  _googlepay() {
    StripePayment.paymentRequestWithNativePay(
            androidPayOptions: AndroidPayPaymentRequest(
                currency_code: 'inr', total_price: '1'),
            applePayOptions: null)
        .then((token) {
      setState(() {
        Fluttertoast.showToast(msg: 'Received');
        print(token.tokenId);
        // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received ${token.tokenId}')));
        _paymentToken = token;
      });
    }).catchError((error) {
      print(error);
    });
  }

  Future initiatePayment(String app) async {
    String response = await FlutterUpi.initiateTransaction(
        app: app,
        pa: "kalawatipawar30@oksbi",
        pn: "Priyanka Pawar",
        tr: "TR1234",
        tn: "This is a test transaction",
        am: "1.00",
        cu: "INR",
        url: "https://www.google.com");
    print(response);
    switch (response) {
      case 'invalid_params':
        Fluttertoast.showToast(
            msg: 'Request parameters are wrong',
            toastLength: Toast.LENGTH_LONG);
        break;
      case 'app_not_installed':
        Fluttertoast.showToast(
            msg: 'Application not Installed', toastLength: Toast.LENGTH_LONG);
        break;
      case 'user_canceled':
        Fluttertoast.showToast(
            msg: 'Payment Cancled', toastLength: Toast.LENGTH_LONG);
        break;
      case 'null_response':
        Fluttertoast.showToast(
            msg: 'No Data Received', toastLength: Toast.LENGTH_LONG);
        break;
      default:
        {
          FlutterUpiResponse flutterUpiResponse = FlutterUpiResponse(response);
          print(flutterUpiResponse.Status);
          if (flutterUpiResponse.Status == 'FAILURE' ||
              flutterUpiResponse.Status == 'Failed') {
            Fluttertoast.showToast(
                msg: 'Payment Failed.Please try again',
                toastLength: Toast.LENGTH_LONG);
          } else {
            Fluttertoast.showToast(
                msg: 'Payment Successfull', toastLength: Toast.LENGTH_LONG);
          }
        }
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: FutureBuilder(
          future: _initiateTransaction,
          builder: (BuildContext context, snapshot) {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Registration Fees.',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          elevation: 15,
                          onPressed: () {},
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Text(
                            '₹1000/-',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // RaisedButton(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10)),
                    //     padding: EdgeInsets.all(10),
                    //     elevation: 10,
                    //     color: Colors.white,
                    //     onPressed: _cardpayment,
                    //     child: ListTile(
                    //       leading: Container(
                    //         width: 100,
                    //         height: 100,
                    //         margin: EdgeInsets.only(right: 15),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(50),

                    //           // border: Border.all(width: 3, color: secondary),
                    //           image: DecorationImage(
                    //               image: AssetImage('assets/card.png'),
                    //               fit: BoxFit.fitHeight),
                    //         ),
                    //       ),
                    //       title: Text(
                    //         'Credit/Debit Card',
                    //         style: TextStyle(fontSize: 20),
                    //       ),
                    //       trailing: Icon(Icons.arrow_forward_ios),
                    //     )),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        elevation: 10,
                        color: Colors.white,
                        onPressed: () {
                          initiatePayment(FlutterUpiApps.PayTM);
                        },
                        child: ListTile(
                          leading: Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),

                              // border: Border.all(width: 3, color: secondary),
                              image: DecorationImage(
                                  image: AssetImage('assets/paytm.png'),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                          title: Text(
                            'PaytmUPI',
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        elevation: 10,
                        color: Colors.white,
                        onPressed: () {
                          initiatePayment(FlutterUpiApps.GooglePay);
                        },
                        child: ListTile(
                            leading: Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),

                                // border: Border.all(width: 3, color: secondary),
                                image: DecorationImage(
                                    image: AssetImage('assets/googlepay.png'),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                            title: Text(
                              'Google Pay',
                              style: TextStyle(fontSize: 20),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios))),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        elevation: 10,
                        color: Colors.white,
                        onPressed: () {
                          initiatePayment(FlutterUpiApps.PhonePe);
                        },
                        child: ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(10),
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),

                                // border: Border.all(width: 3, color: secondary),
                                image: DecorationImage(
                                    image: AssetImage('assets/phonepe.png'),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                            title: Text(
                              'Phonepe',
                              style: TextStyle(fontSize: 20),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios))),
                  ],
                ));
          },
        ));
  }
}
