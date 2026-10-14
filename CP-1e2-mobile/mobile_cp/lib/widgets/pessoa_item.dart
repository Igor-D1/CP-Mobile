import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:Restaurante_Mesa_Cheia/models/clientes.dart';

class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onSaida;
  final VoidCallback onExcluir;

  const PessoaItem({
    super.key,
    required this.pessoa,
    required this.onSaida,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    final noAmbiente = pessoa.noAmbiente;
    final corStatus = noAmbiente ? const Color(0xFF2E7D32) : const Color(0xFF9E9E9E);
    final dataEntrada = DateFormat("HH:mm - dd/MM/yyyy").format(pessoa.dataEntrada);

    return Slidable(
      key: ValueKey(pessoa.identificacao),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: noAmbiente ? (_) => onSaida() : null,
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            icon: Icons.logout,
            label: 'Saída',
          ),
          SlidableAction(
            onPressed: (_) => onExcluir(),
            backgroundColor: const Color(0xFFB3261E),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            label: 'Excluir',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: noAmbiente ? const Color(0xFFD9A441) : const Color(0xFF9E9E9E),
                child: Icon(
                  noAmbiente ? Icons.restaurant : Icons.restaurant_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pessoa.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text('ID: ${pessoa.identificacao}'),
                    const SizedBox(height: 2),
                    Text('Entrada: $dataEntrada'),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: corStatus.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        noAmbiente ? 'No ambiente' : 'Saiu',
                        style: TextStyle(
                          color: corStatus,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}