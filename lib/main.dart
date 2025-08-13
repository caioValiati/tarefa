import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const CarouselForm(),
      ),
    );
  }
}

class CarouselForm extends StatefulWidget {
  const CarouselForm({super.key});

  @override
  State<CarouselForm> createState() => _CarouselFormState();
}

class _CarouselFormState extends State<CarouselForm> {
  final List<FormData> forms = List.generate(5, (_) => FormData());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      itemCount: forms.length,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (context, index) {
        return SizedBox(
          width: 250,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: FormCard(
                data: forms[index],
                onChanged: (newData) {
                  setState(() {
                    forms[index] = newData;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class FormData {
  String nome = '';
  DateTime? dataNascimento;
  String? sexo;
}

class FormCard extends StatefulWidget {
  final FormData data;
  final ValueChanged<FormData> onChanged;

  const FormCard({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  late TextEditingController _nomeController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.data.nome);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _selecionarData() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.data.dataNascimento ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        widget.data.dataNascimento = picked;
      });
      widget.onChanged(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nomeController,
          decoration: const InputDecoration(
            labelText: 'Nome Completo',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            widget.data.nome = value;
            widget.onChanged(widget.data);
          },
        ),
        const SizedBox(height: 8),

        InkWell(
          onTap: _selecionarData,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Data de Nascimento',
              border: OutlineInputBorder(),
            ),
            child: Text(
              widget.data.dataNascimento != null
                  ? "${widget.data.dataNascimento!.day.toString().padLeft(2, '0')}/"
                    "${widget.data.dataNascimento!.month.toString().padLeft(2, '0')}/"
                    "${widget.data.dataNascimento!.year}"
                  : 'Selecione uma data',
            ),
          ),
        ),
        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Sexo',
            border: OutlineInputBorder(),
          ),
          value: widget.data.sexo,
          items: const [
            DropdownMenuItem(value: 'Homem', child: Text('Homem')),
            DropdownMenuItem(value: 'Mulher', child: Text('Mulher')),
          ],
          onChanged: (value) {
            setState(() {
              widget.data.sexo = value;
            });
            widget.onChanged(widget.data);
          },
        ),
      ],
    );
  }
}
