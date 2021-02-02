import 'package:crypto_reminder/blocs/cryptocurrency_bloc.dart';
import 'package:crypto_reminder/models/cryptocurrency.dart';
import 'package:crypto_reminder/networking/api_response.dart';
import 'package:crypto_reminder/view/common/error.dart';
import 'package:crypto_reminder/view/common/loading.dart';
import 'package:flutter/material.dart';

class CryptoScreen extends StatefulWidget {
  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  CryptoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CryptoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Crypto List',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchCryptoList(),
        child: StreamBuilder<ApiResponse<List<CryptoCurrency>>>(
          stream: _bloc.cryptoCurrencyListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return CryptoList(cryptoList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchCryptoList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class CryptoList extends StatelessWidget {
  final List<CryptoCurrency> cryptoList;

  const CryptoList({Key key, this.cryptoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cryptoList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new Text(
                    '${cryptoList[index].symbol}: ${cryptoList[index].lastPrice}');
              },
            ),
          ),
        ),
        new IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: () {},
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
