import 'package:flutter/material.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({super.key});

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  // CONTROLLERS
  final TextEditingController _controllerValue = TextEditingController();

  // VARIABLES
  final List<String> sistemas = ['Escolha', 'Decimal', 'Binário', 'Octal', 'Hexadecimal'];
  String sistemaSelecionado = 'Escolha';
  int? _decimalValue;
  String? _binaryValue;
  String? _octalValue;
  String? _hexaValue;

  // METHODS
  void calcValues() {
    String inputValue = _controllerValue.text;

    if (inputValue.isEmpty) {
      setState(() {
        _decimalValue = null;
        _binaryValue = null;
        _octalValue = null;
        _hexaValue = null;
      });
      return;
    } else if (int.tryParse(inputValue)! < 0){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Digite um valor numérico válido')),);
    }

    int? decimalValue;

    switch (sistemaSelecionado) {
      case "Decimal":
        decimalValue = int.tryParse(inputValue);
        break;
      case "Binário":
        decimalValue = int.tryParse(inputValue, radix: 2);
        break;
      case "Octal":
        decimalValue = int.tryParse(inputValue, radix: 8);
        break;
      case "Hexadecimal":
        decimalValue = int.tryParse(inputValue, radix: 16);
        break;
      default:
        decimalValue = null;
    }

        setState(() {
      if(decimalValue != null){
         _decimalValue = decimalValue;
         _binaryValue = decimalValue.toRadixString(2);
         _octalValue = decimalValue.toRadixString(8);
         _hexaValue = decimalValue.toRadixString(16);
      }
      else{
        _decimalValue = null;
        _binaryValue = null;
        _octalValue = null;
        _hexaValue = null;
      }
  });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Conversor Numérico", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 4,
      backgroundColor: Colors.deepPurple,
    ),
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Conversor de Sistemas Numéricos",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _controllerValue,
                        decoration: InputDecoration(
                          labelText: "Digite um valor",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.input),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          calcValues();
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: sistemaSelecionado,
                        decoration: InputDecoration(
                          labelText: "Sistema de entrada",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        items: sistemas.map((String sistema) {
                          return DropdownMenuItem<String>(
                            value: sistema,
                            child: Text(sistema),
                          );
                        }).toList(),
                        onChanged: (String? novoValor) {
                          setState(() {
                            sistemaSelecionado = novoValor!;
                          });
                          calcValues();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Resultados",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      _buildResultTile("Decimal", Icons.filter_1, _decimalValue?.toString() ?? 'N/A'),
                      Divider(),
                      _buildResultTile("Binário", Icons.filter_2, _binaryValue ?? 'N/A'),
                      Divider(),
                      _buildResultTile("Octal", Icons.filter_3, _octalValue ?? 'N/A'),
                      Divider(),
                      _buildResultTile("Hexadecimal", Icons.filter_4, _hexaValue ?? 'N/A'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildResultTile(String title, IconData icon, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.deepPurple),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "$title:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'RobotoMono',
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}
  }
