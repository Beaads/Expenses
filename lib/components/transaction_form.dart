import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm(this.onSubmit, {super.key});
  final void Function(String, double) onSubmit;

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _submitForm() {
      final title = titleController.text;
      final value = double.tryParse(valueController.text) ?? 0.0;
      if(title.isEmpty || value <= 0) {
        return;
      }
      onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: valueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.white10),
                  ),
                  child: const Text('Nova Transacao',
                      style: TextStyle(color: Colors.purple)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
